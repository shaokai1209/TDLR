clear all;
addpath('./libsvm-new');
addpath('./liblinear-2.1/matlab');
for i = [1:1:1]
%bauma-berlin 52.21 knn/8 alfa/6.0 lambda/10^3 beta/3  gamma/0.005 u1/0.4  u2/0.002 dim/100
% load('bauma_1582.mat');
%     S = double(feature);
% load('bauma_label.mat'); 
%     S_Label=double(label);
% load('berlin_1582.mat');
%     T = double(feature(1:224,:));
%     Ttest= double(feature(225:end,:));
% load('berlin_label.mat');
%     T_Label=double(label(1:224,:));
%     Ttest_Label = double(label(225:end,:));
%     
% %     X = [double(feature),double(label)];
% %     rowrank = randperm(size(X, 1)); % size获得a的行数，randperm打乱各行的顺序
% %     X1 = X(rowrank,:); 
% %     T = X1(1:224,1:1582);
% %     T_Label = X1(1:224,1583);
% %     Ttest = X1(225:end,1:1582);
% %     Ttest_Label = X1(225:end,1583);
   
%     
%berlin-bauma  44.23 knn/4 alfa/0.3 lambda/400 beta/1.5 gamma/0.01 u1/0.005 u2/1  dim/100
load('berlin_1582.mat');
    S = double(feature);
load('bauma_1582.mat');
    T = double(feature(1:121,:));
    Ttest= double(feature(122:end,:));
load('berlin_label.mat'); 
    S_Label=double(label);
load('bauma_label.mat');
    T_Label=double(label(1:121,:));
    Ttest_Label = double(label(122:end,:));

%bauma-enter  36.68 knn/7 alfa/5.1 lambda/10^3 beta/6.0 gamma/0.008 u1/0.005 u2/0.001 dim/100
% load('bauma_1582.mat');
%     S = double(feature);
% load('enterface_1582.mat');
%     T = double(feature(1:704,:));
%     Ttest= double(feature(705:end,:));
% %     [M,N]=size(feature); %读取矩阵行列数;
% %     num = round(M*(7/10)); % 取A的1/3行作为训练集，round为四舍五入取整;
% %     [~,idx]=sort(rand(M,1));%随机排列生成index;
% %     T=double(feature(idx(1:num),:));%根据index选取1/3的A集为B集;
% %     Ttest=double(feature(idx(num+1:M),:));%保存剩余的数据为C集;
% load('bauma_label.mat'); 
%     S_Label=double(label);
% load('enterface_label.mat');
%     T_Label=double(label(1:704,:));
%     Ttest_Label = double(label(705:end,:));
% %     T_Label=double(label(idx(1:num),:));%根据index选取1/3的A集为B集;
% %     Ttest_Label=double(label(idx(num+1:M),:));%保存剩余的数据为C集;

% %enter-bauma  42.30 knn/5 alfa/1.0 lambda/10^3 beta/150 gamma/10 u1/0.01 u2/0.001 dim/100

% load('enterface_1582.mat');
%     S = double(feature);
% load('bauma_1582.mat');
%     T = double(feature(1:121,:));
%     Ttest= double(feature(122:end,:));
% % [M,N]=size(feature); %读取矩阵行列数;
% % num = round(M*(7/10)); % 取A的1/3行作为训练集，round为四舍五入取整;
% % [~,idx]=sort(rand(M,1));%随机排列生成index;
% % T=double(feature(idx(1:num),:));%根据index选取1/3的A集为B集;
% % Ttest=double(feature(idx(num+1:M),:));%保存剩余的数据为C集;
% load('enterface_label.mat'); 
%     S_Label=double(label);
% load('bauma_label.mat');
%     T_Label=double(label(1:121,:));
%     Ttest_Label = double(label(122:end,:));
% % T_Label=double(label(idx(1:num),:));%根据index选取1/3的A集为B集;
% % Ttest_Label=double(label(idx(num+1:M),:));%保存剩余的数据为C集;

%berlin-enter  46.42  knn/5 alfa/0.1 lambda/80 beta/1.5 gamma/1.0 u1/0.01
%u2/0.001
% load('berlin_1582.mat');
%     S = double(feature);
% load('enterface_1582.mat');
%     T = double(feature(1:820,:));
%     Ttest= double(feature(821:end,:));
% load('berlin_label.mat'); 
%     S_Label=double(label);
% load('enterface_label.mat');
%     T_Label=double(label(1:820,:));
%     Ttest_Label = double(label(821:end,:));


% enter -berlin 48.67 knn/6 alfa/0.001 lambda/10^3 beta/500 gamma/20
% % u1/0.1 u2/0.2
% load('enterface_1582.mat');
%     S = double(feature);
% load('berlin_1582.mat');
%     T = double(feature(1:224,:));
%     Ttest= double(feature(225:end,:));
% load('enterface_label.mat'); 
%     S_Label=double(label);
% load('berlin_label.mat');
%     T_Label=double(label(1:224,:));
%     Ttest_Label = double(label(225:end,:));


% load('RML.mat');
%     S = double(feature);
% load('bauma_1582.mat');
%     T = double(feature(1:121,:,:));
%     Ttest= double(feature(122:end,:));
% load('RML_label.mat'); 
%     S_Label=double(label);
% load('bauma_label.mat');
%     T_Label=double(label(1:121,:));
%     Ttest_Label = double(label(122:end,:));

S = normalization(S',1);
S =S';
Ttest=normalization(Ttest',1);
Ttest = Ttest';
Ttest = Ttest(:,1:1582);
T = normalization(T',1);
T = T';
Xt = T(:,1:1582);    
Xs = S(:,1:1582);
Ys = S_Label;
Yt = T_Label;
test_data = Ttest;
test_label = Ttest_Label;
lambda=20;

% options.ReducedDim = 100;
Options = [];
Options.ReducedDim =150;
XS = [Xs;Xt;Ttest];
[eigvector,eigvalue] = PCA1(XS,Options);
XS = XS * eigvector;
Xs = XS(1:size(Xs,1),:);
Xt = XS(size(Xs,1)+1:size(Xs,1)+size(Xt,1),:);
Ttest = XS(size(Xs,1)+size(Xt,1)+1:end,:);
%=====================
% e1 = find(Ys==1);
% e2 = find(Ys==2);
% e3 = find(Ys==3);
% e4 = find(Ys==4);
% e5 = find(Ys==5);
 %knn/8 alfa/6.0 lambda/10^3 beta/3  gamma/0.005 u1/0.4  u2/0.002 dim/100
options = [];
options.knn =8;
options.alfa =0.3;
options.lambda =0.1;
options.beta =0.1;
options.gamma =0.1;
options.u1 = 0;
options.u2 =1;

[cls,acc,A,M,obj]=myDLRTL( Ys,Xs',Xt',Yt,options,Ttest,Ttest_Label);

myacc(i) = acc;
end
% a = std([65.4867256637168,63.7168141592920]);
% Xs = Xs';
% Xt = Xt';
% X=[Xs,Xt];

Zs = Xs*A;
Zs=Zs';
Ztt = Xt*A; 
Ztt=Ztt';
X =[Zs,Ztt];
Xs = Xs';
Xt = Xt';
%mahalanobis  euclidean
   Y = tsne(X','Algorithm','exact','Distance','euclidean','NumPCAComponents',5,'NumDimensions',3);
%    scatter3(Y(:,1),Y(:,2),Y(:,3),[Ys;Yt],'filled');
   
   
   Y1=Y(1:size(Xs,2),:);
   Y2=Y(size(Xs,2)+1:end,:);
   % Plot the result
      figure;
      %subplot(2,3,1);
       axis([-50,50,-50,50]);
     % p=[Xs_label;Xt_label];
 %gscatter(Y(1:size(Ss,2),1),Y(1:size(Ss,2),2),Xs_label);
 %  hold on;
  %  gscatter(Y(size(Ss,2)+1:end,1),Y(size(Ss,2)+1:end,2),Xt_label);
     scatter3(Y1(Ys==1,1),Y1(Ys==1,2),Y1(Ys==1,3),'*','r','LineWidth',1);
     hold on
     scatter3(Y1(Ys==2,1),Y1(Ys==2,2),Y1(Ys==2,3),'*','b','LineWidth',1);
        hold on;
     scatter3(Y1(Ys==3,1),Y1(Ys==3,2),Y1(Ys==3,3),'*','g','LineWidth',1);
        hold on;
     scatter3(Y1(Ys==4,1),Y1(Ys==4,2),Y1(Ys==4,3),'*','y','LineWidth',1);
        hold on;
     scatter3(Y1(Ys==5,1),Y1(Ys==5,2),Y1(Ys==5,3),'*','m','LineWidth',1);
        hold on;
%       scatter(Y1(Xs_label==6,1),Y1(Xs_label==6,2),'*','k','LineWidth',1.5);
%    hold on;
   scatter3(Y2(Yt==1,1),Y2(Yt==1,2),Y2(Yt==1,3),'+','r','LineWidth',1);
     hold on
     scatter3(Y2(Yt==2,1),Y2(Yt==2,2),Y2(Yt==2,3),'+','b','LineWidth',1);
        hold on;
     scatter3(Y2(Yt==3,1),Y2(Yt==3,2),Y2(Yt==3,3),'+','g','LineWidth',1);
        hold on;
     scatter3(Y2(Yt==4,1),Y2(Yt==4,2),Y2(Yt==4,3),'+','y','LineWidth',1);
        hold on;
     scatter3(Y2(Yt==5,1),Y2(Yt==5,2),Y2(Yt==5,3),'+','m','LineWidth',1);
        hold on;
%       scatter(Y2(Xt_label==6,1),Y2(Xt_label==6,2),'+','k','LineWidth',1.5);
%       hold on;
        box on;
      set( gca, 'XTick', [], 'YTick', [],'ZTick', [],'FontSize',17,'FontWeight','bold' );
%legend('DGTSC(graph)','DGTSC');
    view(-20,20);
  % xlabel('(a) Original data');
%     xlabel('(b) JALDA');

% disp(acc);
% cnt = 0;
% for u21 = [0.001,0.005,0.01,0.05,0.1,0.5,1]
%     cnt = cnt+1;
%     disp('************************');
%     options = [];
%     options.knn =5;
%     options.alfa =1;
%     options.lambda =1000;
%     options.beta =150;
%     options.gamma =10;
%     options.u1 = 0.01;
%     options.u2 =u21;
% 
%     [cls,acc,A,M,obj]=myDLRTL( Ys,Xs',Xt',Yt,options,Ttest,Ttest_Label);
%     macc(1,cnt) = u21;
%     macc(2,cnt) = acc;
% end
% act=Ttest_Label;
% act1=act';
% det=cls;
% det1=det';
% confusion_matrix1(act1,det1);

% X = [Xs;Xt];
% options.ReducedDim =5;
% [P1,~] = PCA1(X,options);
% disp(size(P1));
