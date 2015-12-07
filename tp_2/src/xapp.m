function [X]= xapp()

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

save("-text","XAPP.dat", 'xapp');
save("-text","YA.dat", 'Ya');
save("-text","XTEST.dat", 'xtest');
save("-text","YT.dat", 'Yt');

endfunction