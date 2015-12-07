%xapp pixel1    pixel2    pixel3 ...
%     example1  example1  example1
%     example2  example2

% Une fonction retourne succes rate au lieu de error rate
% Attention base de test 200<->5000
% Pas de boucle for

%Commande pour sauvegarder
%save Res.dat RES RES2 xapp ...
%load Res.dat
%Dans la boucle for faire une sauvegarde pour chaque apprentissage 

%{
Le nombre de sortie est déterminée par le nombre de classe
les couches cachées on s'en fout
le nombre de classificateur 

Dans notre exemple on fait un ceil pour arrondir car on veut du discret
%}

%Yapp = simple classe numérique 
%Yt multiclasse binaire

%dicotomie 300 neurones
%Apprendre sur bcp de couche n'aide pas c'est pire
%Retro propagation descente de gradient (c pas feedforward = avant)
%dictionnaire de symboles

%algo pour déterminer le nombre max d'iterations.

%{
RES = [];
for i=1:size(IDS)
  [TEA, TET, pmc] = apprend_pmc(xapp_rand(:,IDS([1:i],1)),Ya,xtest_rand(:,i),Yt,0.01,{10,10});
  SuccessRateApp  = test_classif_pmc(xapp(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest];
end
save resIDS.dat res;
%IDS([1:i],1)
%}

function [X] = main (thread_id, n_threads)
source "pmc.m";

load "XAPP.dat"
load "XTEST.dat"
load "YA.dat"
load "YT.dat"
 
% Learning
RES = [];
range = size(xapp,2) / n_threads;

for i=(range * thread_id) +1:range * (thread_id+1)
  [TEA, TET, pmc] = apprend_pmc(xapp(:,i),Ya,xtest(:,i),Yt,0.01,{10,10});

  SuccessRateApp  = test_classif_pmc(xapp(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest]; 
  printf("Learning success : %f\nTest success : %f\n", SuccessRateApp, SuccessRateTest);

end

str = sprintf("RES%d.dat",thread_id); 
save("-text",str, 'RES');
end

