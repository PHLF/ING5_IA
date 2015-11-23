states = zeros(1, 10);
policy = ones (1,16);
value = zeros (1,16);

%Comprendre ce qu'il se passe, si il faut apprendre en m^eme temps etc

%Q-learning
Q = rand(16,4);
E = rand(16);

%Initialisation
n = 0.1;      % Poids des recompenses avenir
gamma = 0.9;  % Recompense prochaine steps


s_inter  = 0;
s = ceil(rand*16);


for i = 1:1000
    a = e_greedy(s,i,1000,Q)
    [s_inter, r] = go(s,a)
    Q(s, a) = Q(s, a) +  n*(r + gamma*max(Q(s_inter, :)) - Q(s, a));
    s = s_inter;
end



%Initialise l'etat initiale de toto
states(1) = ceil(rand*16);

%Selon l'etat precedent on calcul l etat suivant
for u = 2:10
    a = e_greedy(states(u-1), u, 10,Q); % e_greedy trop fort pour ce cas à retravailler
    s_inter = go(states(u-1), a);
    states(u) = s_inter(1);
end

%Generation image toto
walkshow(states','toto.png');
