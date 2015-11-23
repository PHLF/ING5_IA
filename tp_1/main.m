states = zeros(1, 10);
policy = ones (1,16);
value = zeros (1,16);
#Dans le rapport il faut des réflexions, est-ce que si on apprends tout en meme
#si on apprend séparément etc etc

#Position possible quand on marche 2 3 4 5 8 9 13 14 
rew = [ 0,-1,0,-1;  # position 1 non-voulue, les actions 0 lui permettent de revenir dans une position normale
        -1,0,-1,0;  # position 2 on donne -1 quand le mouvement est impossible ou si il retourne en arrière.
        0,-1,-1,-1;  # //
        -1,-1,1,-1; # Position 4 intermédiaire,on donne une récompense à l'action qui le fait avancer 
        
        -1,0,-1,0;  # CF position 2
        0,-1,0,-1;  # CF position 1
        0,-1,0,-1;  # CF position 1
        -1,0,-1,-1;  # CF position 2
        
        -1,-1,0,-1;
        -1,-1,0,-1;
        -1,-1,-1,-1;  # Position 11, ne marche pas si g petit sinon 0,-1,0,-1;
        -1,0,-1,0;
        
        1,-1,-1,-1; # CF position 4
        -1,-1,-1,0; 
        -1,-1,-1,-1;  # CF position 11 sinon   -1,0,-1,0;
        -1,0,-1,0]; # CF position 1

        
# On tente a 0.5 
g = 0.001;

trans = [ 2,4,5,13;
          1,3,6,14;
          4,2,7,15;
          3,1,8,16;#4
          
          6,8,1,9;
          5,7,2,10;
          8,6,3,11;
          7,5,4,12;#8
          
          10,12,13,5;          
          9,11,14,6;          
          12,10,15,7;
          11,9,16,8;#12
          
          14,16,9,1;
          13,15,10,2;                 
          16,14,11,3;     
          15,13,12,4];



#assez d'iteration
for p = 1:100
  for s = 1:16
    [dummy, policy(s)] = max(rew(s,:) + g * value(trans(s,:)));
  end
  
  for s = 1:16
    a = policy(s);
    value(s)=rew(s,a) + g * value(trans(s,a));
  end  
end

#Initialise l'etat initiale de toto
states(1) = ceil(rand*16);
#states(1) = 11;
#Selon l'etat precedent on calcul l etat suivant
for u = 2:10
    states(u) = trans(states(u-1),policy(states(u-1)));
end

#Generation image toto
walkshow(states',"toto.png");


