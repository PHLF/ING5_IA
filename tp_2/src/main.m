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
function [X] = main (thread_id, n_threads)
source "pmc.m";
load "usps_napp10.dat"
%centré xapp-2 * 1


Ya=change_Y_discri(yapp);
Yt=change_Y_discri(ytest);

%NORMALISER
xmax=max(max(max(xapp),max(xtest)));

%for i = 1:size(xmax)
new_xapp  =   xapp  / xmax;
new_xtest =   xtest / xmax;
%end

%CENTRALISER
new_xapp2  =  (new_xapp .*2 ) .-1;
new_xtest2 = (new_xtest .*2) .-1;

xapp = new_xapp2;
xtest = new_xtest2;

% Randomisation
for i = 1:size(xapp,1)
  id1 = ceil(rand * size(xapp,1));
  id2 = ceil(rand * size(xapp,1));
  tmpX = xapp(id1,:);
  tmpY = Ya(id1,:);
  xapp(id1,:) = xapp(id2,:);
  Ya(id1,:) = Ya(id2,:);
  xapp(id2,:) = tmpX;
  Ya(id2,:) = tmpY;
end


%{
% Normalisation % Centrer

max_colonne_xtest = max(xtest);
max_colonne_xapp = max(xapp_rand);
min_colonne_xtest = min(xtest);
min_colonne_xapp = min(xapp_rand);

xapp_norm = xapp_rand;
for i = 1:size(xapp_rand,2)
  xapp_norm(:,i) = (xapp_rand(:,i) - min_colonne_xapp(i)) / max_colonne_xapp(i);
end
%}
 
 
 
% Learning
RES = [];
str = sprintf("RES%d.dat",thread_id); 
save("-text",str, 'RES');

range = size(xapp,2)/n_threads;
for i=(range * thread_id) +1:range * (thread_id+1)
  [TEA, TET, pmc] = apprend_pmc(xapp(:,i),Ya,xtest(:,i),Yt,0.01,{10,10});

  SuccessRateApp  = test_classif_pmc(xapp(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest]; 
end
str = sprintf("RES%d.dat",thread_id); 
save("-text",str, 'RES');

IDS = sortrows(RES,-3);

str = sprintf("IDS%d.dat",thread_id); 
save("-text",str, 'IDS');

end
%{
RES = [];
for i=1:size(IDS)
  [TEA, TET, pmc] = apprend_pmc(xapp_rand(:,IDS([1:i],1)),Ya,xtest_rand(:,i),Yt,0.01,{10,10});
  SuccessRateApp  = test_classif_pmc(xapp(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest];
end
save resIDS.dat res;%}
%IDS([1:i],1)

printf("Learning success : %f\nTest success : %f\n", SuccessRateApp, SuccessRateTest);
%}
%I = 1
%Learning success : 0.520000
%Test success : 0.439958

%Après inversion app test
%Learning success : 0.183010
%Test success : 0.100000

%
%Learning success : 0.183010
%Test success : 0.100000
