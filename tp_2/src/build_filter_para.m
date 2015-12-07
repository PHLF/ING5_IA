function [X] = build_filter_para (thread_id, n_threads)

ResList = glob("RES*.dat");
% Loop through the elements of the cell
RES[];
for i = 1:length(ResList)
 RES=[RES;ResList{i,1}];
end

IDS=sortrows(RES,-3);

RES = [];
range=size(IDS)/n_threads;
for i=range*thread_id+1:range*(thread_id+1)
  [TEA, TET, pmc] = apprend_pmc(xapp_rand(:,IDS([1:i],1)),Ya,xtest_rand(:,i),Yt,0.01,{10,10});
  SuccessRateApp  = test_classif_pmc(xapp(:,i),Ya,pmc);
  SuccessRateTest = test_classif_pmc(xtest(:,i),Yt,pmc);

  RES = [RES;i SuccessRateApp SuccessRateTest];
end

IDS = sortrows(RES,-3);

str = sprintf("IDS%d.dat",thread_id); 
save("-text",str, 'IDS');

end

