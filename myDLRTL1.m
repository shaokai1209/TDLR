function [cls,Acc,A,M,obj]=myDLRTL1(gnd,Xs,Xt,Yt_pre,options,test_data,test_label)
options1 = [];
options1.knn = options.knn;
options1.alfa = options.alfa ;
options1.lambda = options.lambda;
options1.beta = options.beta ;
options1.gamma = options.gamma;
options1.u1 = options.u1;
options1.u2 = options.u2;
for i=1:10
    [A,M,obj]=DLRTL(gnd,Xs,Xt,Yt_pre,options1);
    obt_label=Xt'*A;
    con=size(obt_label,2);
    [g1,g2]=sort(obt_label,2);
    ord=g2(:,con);
    Yt_pre=ord;
    
    obt_label=test_data*A;
    con=size(obt_label,2);
    [g1,g2]=sort(obt_label,2);
    ord=g2(:,con);
    cls=ord;
    Acc=(length(find(ord==test_label))/length(test_label))*100;
    disp(Acc);
end



function [A,M,obj]=DLRTL(gnd,Xs,Xt,Yt_pre,options)
%% X(nXm);Y(nXc);A(mXc);||XA-Y-B.*M||+lambda*Tr(A'*X'*L*XA)
%%
knn = options.knn;
alfa = options.alfa ;
lambda = options.lambda;
beta = options.beta ;
gamma = options.gamma;
u1 = options.u1;
u2 = options.u2;
% model= svmtrain(gnd,Xs','-s 0 -t 0 -c 1 -g 1 ');
% [ Y_tar_pseudo, acc,~] = svmpredict(Yt_pre,Xt',model);
%------------------------------------
[ds,ns] = size(Xs);
[dt,nt] = size(Xt);
% [dst,nst]=size(T_data);
if(ds==dt)
    X = [Xs,Xt];
    X = X*diag(sparse(1./sqrt(sum(X.^2))));
else
    X = [Xs,zeros(ds,nt);zeros(dt,ns),Xt];
    X = X*diag(sparse(1./sqrt(sum(X.^2))));
end
n = ns+nt;
% Construct centering matrix
H = eye(n)-1/(n)*ones(n,n);
% Construct MMD matrix
% M0,margin distributions between domains are drawn close under Z=Transfer(A)X
e = [1/ns*ones(ns,1);-1/nt*ones(nt,1)];
C = length(unique(gnd));
Mc = e * e' * C;
%Mc
if ~isempty(Yt_pre) && length(Yt_pre) == nt
    for c = reshape(unique(gnd),1,C)
        e = zeros(n,1);
        e(gnd==c) = 1 / length(find(gnd==c));
        e(ns+find(Yt_pre==c)) = -1 / length(find(Yt_pre==c));
        e(isinf(e)) = 0;
        Mc= Mc + e*e';
    end
end

Mc = Mc / norm(Mc,'fro');
%-------------------------------------
num_l=length(gnd);
Y = Pre_label(gnd,num_l);  
B=Construct_B(Y);
L=Construct_L(X,[gnd; Yt_pre],knn);  
Niter=300;
[x33,y33]=size(Y);
M=rand(x33,y33);
%==================
A = ones(ds,C);
v=sqrt(sum(A.*A,2));
G = diag(0.5./(v));
%=================
Q = ones(nt,ns);
v1 = sqrt(sum(Q'.*Q',2));
Z = diag(0.5./(v1));
% tempp=inv(Xs*Xs'+lambda*X*(Mc+0.1*L)*X'+0.01*eye(size(X,1)));
for iter=1:Niter
%     iter
    %tempp=inv(Xs*Xs'+X*(lambda*Mc+alfa*L)*X'+beta*eye(size(X,1))+gamma*G);
%     A=(Xs*Xs'+X*(lambda*Mc+alfa*L)*X'+beta*eye(size(X,1))+gamma*G)\(Xs*(Y+B.*M));%tempp*(Xs*(Y+B.*M))
      A=(Xs*Xs'+X*(lambda*Mc+alfa*L)*X'+beta*eye(size(X,1))+gamma*G)\(Xs*(Y+B.*M));
%     Y = Xs'*A\(eye(size(L))-L)-B.*M;
    F=Xs'*A-Y;
    M_original=B.*F;
    [x11,y11]=size(F);
    %%
    for i=1:x11
    for j=1:y11
        M(i,j)=max(M_original(i,j),0);
    end
    end  
   
%     M=M_original;
    %%
    sam1=Xs'*A-Y-(B.*M);
    sam2=A'*X*L*X'*A;
    obj(iter)=trace(sam1'*sam1)+lambda*trace(sam2);
    if iter>2
        if abs(obj(iter)-obj(iter-1))<0.01
            break
        end
    end
    
%update G
    if(ds==dt)
%         G(1:ns,1:ns) = diag(sparse(1./(sqrt(sum(A(1:ns,:).^2,2)+eps))));
%     else
        G = diag(sparse(1./(sqrt(sum(A.^2,2)+eps))));
    end
    Z = diag(sparse(1./(sqrt(sum(Q'.^2,2)+eps))));
end




