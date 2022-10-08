function Y = Pre_label(gnd,num_l )
%% gnd:标签向量；num_l:表示有标签样本的数目；Y_label:生成的标签矩阵；
%%---------------------------------------------------------------------------
nClass=length(unique(gnd));
% num1=length(gnd);        % num1表示样本的个数
Y_original=zeros(nClass,length(gnd));    % 原始的标签矩阵全部为零  

for i=1:num_l
    for j=1:nClass
        if j==gnd(i)
            Y_original(j,i)=1;   % 为有标签的样本赋标签为1
        end  
    end
end
Y=Y_original';