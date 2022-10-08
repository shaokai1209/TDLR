function L=Construct_L(X,gnd,knn)
options = [];
% options.NeighborMode = 'KNN';
options.k = knn;     %近邻数目
% t=1; 76%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options.NeighborMode = 'Supervised';
options.gnd = gnd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
options.WeightMode = 'HeatKernel';
options.t = 10^0;     %热核参数
W = constructW(X',options);
% [m,n]=size(W);
aa=sum(W);
DDD=diag(aa);
L=DDD-W;
%%
% options = [];
% options.NeighborMode = 'Supervised';
% options.gnd = gnd;
% options.WeightMode = 'HeatKernel';
% options.t = 1;
% W = constructW(fea,options);