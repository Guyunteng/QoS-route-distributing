%����������ȴӴ�С����Ȼ��ѡ����ȵ�k�����޳���k��·�������·���
%�Ż�����Ϊ��Ȩ�ص�dij

sumopt=0;
sumnoopt=0;
%clear all;load chushijuzhen.mat;
temp2=[];
temp1=[];
tianchong=0;
for i=1:flownum
    temp2=[temp2 nooptcost(flow,link,i)];
end
    sumnoopt=sum(temp2);%�����Ż�ǰ����

ffn=flownum
a={};
b={};
c={};
d={};
for i=1:ffn
    a{i}=flow{i}.id;
    b{i}=flow{i}.bandwidth;
end

for i=1:ffn
    for k=1:(ffn-i)
        if(b{k}<b{k+1})
            temp=b{k};
            b{k}=b{k+1};
            b{k+1}=temp;
            temp=a{k};
            a{k}=a{k+1};
            a{k+1}=temp;
        end
    end
end
ffn=round(flownum*rand())
a=a(1:ffn)
b=b(1:ffn)
%�����������д������򣬲�ѡȡ����ffn������a�н����Ż�
    if(sumnoopt==0)
        [temp1,tempflow,templink]=dijoptad22(flow,link,linjieLINK,nodenum,a,G);
    else
        [temp1,tempflow,templink]=dijoptad22(flow,link,linjieLINK,nodenum,a,G);
    end
        flow=tempflow;
        link=templink;
 

for i=1:flownum
    temp1=[temp1 nooptcost(flow,link,i)];

end
sumopt=sum(temp1);


    if(sumnoopt==0)
    sumnoopt=9999999;
    end
for i=1:flownum
    if(flow{i}.nowcost~=0 && flow{i}.pathnum~=0)
        tianchong=tianchong+1;
    
    end
end
    tianchong
[sumopt sumnoopt]
100*sumopt/sumnoopt


