function xiaohui()
%% ������
Tag_A= Disrupt();%����Ǿ��������˳�����
drawmap(Tag_A);%���ձ�Ǿ�����ʾƴͼ

global Tag;%Tag�Ǳ�Ǿ��󣬶����ȫ�ֱ��������㴫�ݲ���
Tag=Tag_A;
set(gcf,'windowButtonDownFcn',@ButtonDownFcn);%������ʱ����ButtonDownFcn����



function ButtonDownFcn(src,event)
%% �ص�������������¼�����ʱ����
pt=get(gca,'CurrentPoint');%��ȡ��ǰ�����λ������
xpos=pt(1,1);%��������ĺ�����ʵ��ֵ
ypos=pt(1,2);%���������������ʵ��ֵ
   
col = ceil(xpos/100);%��������ֵת��Ϊ����
row = ceil(ypos/100);%��������ֵת��Ϊ����

global Tag; %ȫ�ֱ�������

if(col<=3&&col>0)&&(row<=3&&row>0)%�����λ������Ч��Χ��    
    Tag=movejig(Tag,row,col);%�����λ���ƶ�ƴͼ
    
    drawmap(Tag)%��ʾƴͼ
    
    order = [1 2 3;4 5 6;7 8 0];%˳�����
    zt = abs(Tag-order);%�Ƚ���������
    if sum(zt(:))==0 %˳���Ѿ���ȫ�Ǻ�
        image=imread('xiaohui.jpg');
        imshow(image) %��Ϸ��ɣ���ȫƴͼ
        msgbox('You did a good job ,��ϲ��ɣ�����') %��ʾ�����Ϣ
        pause(0.5);%�ӳٰ���
        close all %��Ϸ�������ر�����ͼ�񴰿�
    end
    
else
    return
    
end




function tag=movejig(tag,row,col)
 %% 4��if��4������Բ�ͬλ�ô��ĵ��������������ʽͳһ
    num = tag(row,col);%���λ���������һ��
    if (row>1)&&(tag(row-1,col)==0)%���λ���ڵڶ�������У��հ׿��ڵ��λ�õ���һ��
        tag(row-1,col) = num;%��������λ���ϵ�ֵ
        tag(row,col) = 0;
    end
    if (row<3)&&(tag(row+1,col)==0)%���λ���ڵ�һ��ڶ��У��հ׿��ڵ��λ�õ���һ��
        tag(row+1,col) = num;
        tag(row,col) = 0;
    end
    if (col>1)&&(tag(row,col-1)==0)%���λ���ڵڶ�������У��հ׿��ڵ��λ�õ����һ��
        tag(row,col-1) = num;
        tag(row,col) = 0;
    end
    if (col<3)&&(tag(row,col+1)==0)%���λ���ڵڶ�������У��հ׿��ڵ��λ�õ��ұ�һ��
        tag(row,col+1) = num;
        tag(row,col) = 0;
    end
   


function y = Disrupt()
%% �������ԭƴͼ����˳��
y =[1,2,3;4,5,6;7,8,0];

for i = 1:360
    row=randi([1,3]);%����һ����Χ��1��3������
    col=randi([1,3]);
    y=movejig(y,row,col);%����������Ķ�������ƴͼ
end



function x = choose(image,index)
%% ��������ѡ���Ӧλ���ϵ�ƴͼ��
if index>0 %���Ϊ1��2��3��4��5��6��7��8��ƴͼ��
    % ���������row�Լ�����column
    row=fix((index-1)/3);
    column=mod(index-1,3);
    % �ָ����Ӧƴͼ������
    x=image(1+row*100:100*(row+1),1+column*100:100*(column+1),:);
else
    x=uint8(255*ones(100,100,3));%ƴͼ��0��������
end

function drawmap(A)
%% �������������Ӧƴͼ��Ӧ��ʾͼƬ
origin=imread('xiaohui.jpg');
image=origin;

% ��Ҫ��ʾ��ƴͼ���и�ֵ
for row=1:3
    for col=1:3
    image(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=choose(origin,A(row,col));
    end
end

imshow(image)%��ʾƴͼ
