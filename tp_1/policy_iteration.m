function [states]=iterative_policy()
%variables:
rew=    [ 0, 0, 0, 0;       %1
          0, 0, 0, 0;       %2
          0, 0, 0, 0;       %3
          0, 0, 0, 0;       %4
          0, -1, 0, 0;       %5
          0, 0, 0, 0;       %6
          0, 0, 0, 0;       %7
          0, 1, 0, 0;       %8
          0, 0, 0, 0;       %9
          0, 0, 0, 0;       %10
          0, 0, 0, 0;       %11
          0, 0, 0, 0;       %12
          1, 0, 0, 0;       %13
          -1, 0, 0, 0;       %14
          0, 0, 0, 0;       %15
          0, 0, 0, 0 ];     %16

%2->3->4->8->5->9->13->14->2
%5->9->13->14->2->3->4->9->5

%Tous les états correspondants à des états qui font avancer le robot.
fwd_states=[3, 4, 8, 9, 12, 13, 14, 15];

trans= [2 ,4 ,5 ,13;    %1
    1 ,3 ,6 ,14;        %2
    4 ,2 ,7 ,15;        %3
    3 ,1 ,8 ,16;        %4
    6 ,8 ,1 ,9;         %5
    5 ,7 ,2 ,10;        %6
    8 ,6 ,3 ,11;        %7
    7 ,5 ,4 ,12;        %8
    10 ,12 ,13 ,5;      %9
    9 ,11 ,14 ,6;       %10
    12 ,10 ,15 ,7;      %11
    11 ,9 ,16 ,8;       %12
    14 ,16 ,9 ,1;       %13
    13 ,15 ,10 ,2;      %14
    16 ,14 ,11 ,3;      %15
    15 ,13 ,12 ,4];     %16
    
    policy = ones (1 , 16);
    value = zeros (1 , 16);
    g=0.5;

    for s=1:16
        for a=1:4
            %On ajoute une pénalité si la valeur de l'état suivant ne
            %correspond pas à un état qui fait avancer le robot.
            temp=trans(s,a)==fwd_states;
            rew(s,a)=rew(s,a)-~any(temp);
        end
    end
    
    %learning process
    for p = 1:100
        for s = 1:16
            [~, policy(s)] = max(rew(s,:)+(g*value(trans(s,:))));
        end
        for s = 1:16
            a = policy(s);
            value(s) = rew(s,a)+g*value(trans(s,a));
        end
    end
    
    %testing learning process through n frames
    s=1;
    for n=1:20
        a=policy(s);
        s=trans(s,a);
        states(n)=s;
    end
    
end