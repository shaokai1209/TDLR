function Y = Pre_label(gnd,num_l )
%% gnd:��ǩ������num_l:��ʾ�б�ǩ��������Ŀ��Y_label:���ɵı�ǩ����
%%---------------------------------------------------------------------------
nClass=length(unique(gnd));
% num1=length(gnd);        % num1��ʾ�����ĸ���
Y_original=zeros(nClass,length(gnd));    % ԭʼ�ı�ǩ����ȫ��Ϊ��  

for i=1:num_l
    for j=1:nClass
        if j==gnd(i)
            Y_original(j,i)=1;   % Ϊ�б�ǩ����������ǩΪ1
        end  
    end
end
Y=Y_original';