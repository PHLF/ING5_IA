states = zeros(1, 10);
policy = ones (1,16);
value = zeros (1,16);

%Comprendre ce qu'il se passe, si il faut apprendre en m^eme temps etc

%Q-learning
Q = rand(16,4);
E = rand(16);

r = 0;
eta = 0.05;
gamma = 0.9;
epsilon = 0.05;
s_inter  = 0;
s = rand(16);
a = 0;
for i = 1:1000
    a = e_greedy(s,i,100,Q);
    [s_inter, r] = go(s,a);
    Q(s, a) = Q(s, a) +  eta*(r + gamma*max(Q(s_inter, :)) - Q(s, a));
    s = s_inter;
end



%Initialise l'etat initiale de toto

states(1) = ceil(rand*16);
%Selon l'etat precedent on calcul l etat suivant
for u = 2:10
    a = e_greedy(Q, states(u-1), 0);
    s_r = go(states(u-1), a);
    states(u) = s_r(1);
end

%Generation image toto
walkshow(states','toto.png');
