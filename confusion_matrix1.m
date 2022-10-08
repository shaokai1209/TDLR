function confusion_matrix1(act1,det1)

[mat1,order] = confusionmat(act1,det1);
k=max(order);             %kΪ����ĸ���

lab=[];
lab(1,1)=length(find(act1==1));
lab(1,2)=length(find(act1==2));
lab(1,3)=length(find(act1==3));
lab(1,4)=length(find(act1==4));
lab(1,5)=length(find(act1==5));
for i=1:5
    for j=1:5
        mat(i,j)=mat1(i,j)/lab(1,i);
    end
end
        




%Ҳ����ʵ�飬�Լ������������
%mat = rand(5);  %# A 5-by-5 matrix of random values from 0 to 1
%mat(3,3) = 0;   %# To illustrate
%mat(5,2) = 0;   %# To illustrate

imagesc(mat); %# Create a colored plot of the matrix values
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are

%#black and lower values are white)
textStrings = num2str(mat(:),'%0.02f');       %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding

%% ## New code: ###�����ǲ���ʾС��������0���ÿհ״���
% idx = strcmp(textStrings(:), '0.00');
% textStrings(idx) = {'   '};
%% ################

%# Create x and y coordinates for the strings %meshgrid��MATLAB�������������������ĺ��� 
[x,y] = meshgrid(1:k);  
hStrings=text(x(:),y(:),textStrings(:),'HorizontalAlignment','center','FontSize',18);
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
%������[mat(:) >midValue]����1X3���ʸ��(��ɫֵ����Ϊ����3��Ԫ�ص���ֵʸ���������Ѿ���[mat(:) > midValue]��Ϊ����textColors��Ԫ�ء�
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors��
%num2cell(textColors, 2)��2 ����ֱ�б��и���ṹ����ת������������ ���ṹ����ת�����������У�
%Ȼ��setȥ�غ����hStrings��

%�����������8�ɸ����Լ��ķ���������и��� 
set(gca,'XTick',1:5,...                                    
        'XTickLabel',{'AN','DI','FE','HA','SA'},...  %#   and tick labels
        'YTick',1:5,...                                    %ͬ��
        'YTickLabel',{'AN','DI','FE','HA','SA'},...
        'TickLength',[0 0]);
set(gca,'FontName','Times New Roman','fontweight','bold','FontSize',18);