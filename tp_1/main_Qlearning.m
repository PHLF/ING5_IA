states = zeros(1, 10);
policy = ones (1,16);
value = zeros (1,16);

% Comprendre ce qu'il se passe, si il faut apprendre en même temps etc

% Q-learning 

Q = rand(16,4);
E = 1;
states(1) = ceil(rand*16); 

 for i = 1:100
  a = e_greedy(states(i),i,100,Q);
  [s, r] = go(states(i),a);
 end
  


%Initialise l'etat initiale de toto

%states(1) = 11;
%Selon l'etat precedent on calcul l etat suivant
for u = 2:10
    states(u) = trans(states(u-1),policy(states(u-1)));
end

%Generation image toto
walkshow(states','toto.png');