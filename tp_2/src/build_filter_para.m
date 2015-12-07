function [X] = build_filter_para (thread_id, n_threads)

source "pmc.m";
load "XAPP.dat";
load "XTEST.dat";
load "YT.dat";
load "YA.dat";

ResList = glob("RES*.dat");
% Loop through the elements of the cell
RES=[];
for i = 1:length(ResList)
s=load(ResList{i,1},"RES");
 RES=[RES;s.("RES")];
end


IDS=sortrows(RES,-3);






RES = [];
range=size(IDS)/n_threads;
for i=range*thread_id+1:range*(thread_id+1)
  [TEA, TET, pmc] = apprend_pmc(xapp(:,IDS([1:i],1)),Ya,xtest(:,IDS([1:i],1)),Yt,0.01,{10,10});
  SuccessRateApp  = test_classif_pmc(xapp(:,IDS([1:i],1)),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,IDS([1:i],1)),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest];
end

IDS = sortrows(RES,-3);

str = sprintf("IDS%d.dat",thread_id); 
save("-text",str, 'IDS');
str = sprintf("RES%d.dat",thread_id); 
save("-text",str, 'RES');
end

