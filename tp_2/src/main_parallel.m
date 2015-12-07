%% Copyright (C) 2015 ph
%% 
%% This program is free software; you can redistribute it and/or modify it
%% under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 3 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*- 
%% @deftypefn {Function File} {@var{retval} =} main_parallel (@var{input1}, @var{input2})
%%
%% @seealso{}
%% @end deftypefn

%% Author: ph <ph@DESKTOP-H9UIVG0>
%% Created: 2015-12-05

%function [X] = main_parallel (thread_id, n_threads)

source "pmc.m";
load "usps_napp10.dat"

Ya=change_Y_discri(yapp);
Yt=change_Y_discri(ytest);

% Randomisation
rand_vec  = randperm(size(Ya));

xapp_rand = xapp(rand_vec,:);
Ya_rand   = Ya(rand_vec,:); 

% Normalisation % Centrer
max_colonne_xtest = max(xtest);
max_colonne_xapp = max(xapp_rand);

min_colonne_xtest = min(xtest);
min_colonne_xapp = min(xapp_rand);

xapp_norm = xapp_rand;
for i = 1:size(xapp_rand,2)
  xapp_norm(:,i) = abs((xapp_rand(:,i) - min_colonne_xapp(i)) / max_colonne_xapp(i));
  xtest(:,i)=abs(xtest(:,i)-min_colonne_xtest(i)/max_colonne_xtest(i));
end

 % Packages Octave utilisés: statistics, io, nan
selected_features=stepwisefit(Ya_rand,xapp_norm);

xapp_fit=xapp_norm(:,selected_features);

[TEA, TET, pmc]=apprend_pmc(xapp_fit,Ya,xtest(:,selected_features),Yt,0.01,{10,10});

 SuccessRateApp  = test_classif_pmc(xapp_fit,Ya,pmc);
 SuccessRateTest = test_classif_pmc(xtest(:,selected_features),Yt,pmc);


%{
% Learning
% range=(size(xapp_rand,2)/n_threads);
RES_T = [];

for i=(thread_id-1)*range+1:thread_id*range
  [TEA, TET, pmc]=apprend_pmc(xapp_norm(:,i),Ya,xtest(:,i),Yt,0.01,{10,10});

  SuccessRateApp  = test_classif_pmc(xapp_norm(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES_T = [RES_T;i SuccessRateApp SuccessRateTest];
end
temp=sortrows(RES_T,-3);
IDS_T = temp(,1)

X=[];
for i=1:range
temp1=IDS_T([1:i]);
temp2=xapp(:,temp1);
  X=[X;temp2];
end

name=num2str(thread_id);
name=sprintf('Tid_%d_X.mat', name); 
save("-text", name, 'X');
%}

save("-text","X_test.mat",'xapp_fit');
%IDS([1:i],1)

printf("Learning success : %f\nTest success : %f\n", SuccessRateApp, SuccessRateTest);

%I = 1
%Learning success : 0.520000
%Test success : 0.439958

%Après inversion app test
%Learning success : 0.183010
%Test success : 0.100000

%
%Learning success : 0.183010
%Test success : 0.100000

%end
