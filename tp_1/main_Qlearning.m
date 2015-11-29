states = zeros(1, 10);
policy = ones (1,16);
value = zeros (1,16);

% Comprendre ce qu'il se passe, si il faut apprendre en m^eme temps etc

% Q-learning
Q = rand(16,4);
E = rand(16);
iter_max=1000;

% Initialisation
n = 0.1;      % Poids des recompenses avenir
gamma = 0.9;  % Recompense prochaine steps


s_inter  = 0;
s = ceil(rand*16);


for k = 1:iter_max
    [e, a] = e_greedy(s,k,iter_max,Q);
    [s_inter, r] = go(s,a);  
    
    Q(s, a) = Q(s, a) +  n*(r + gamma*max(Q(s_inter, :)) - Q(s, a));
    
    % Pour observer la convergence.
    Q_plot(k)= abs(n*(r + gamma*max(Q(s_inter, :)) - Q(s, a)));
    
    s = s_inter;
    
    epsilon(k)=e;
    iter(k)=k;
    
end

plot(iter,epsilon,iter,Q_plot,'r');
hold on;


% Initialise l'etat initiale de toto
states(1) = ceil(rand*16);

% A partir d'ici on veut vérifier si l'apprentissage a bien fonctionné

% Selon l'etat precedent on calcul l etat suivant
for u = 2:10
    [e, a] = e_greedy(states(u-1), u, 10,Q);
    s_inter = go(states(u-1), a);
    states(u) = s_inter(1);
end

% Generation image toto
figure();
walkshow(states','toto.png');