%����·�Ż�����˳�����ѡȡk��

sumopt=0;
sumnoopt=0;
%netnet;
%clear all;load chushijuzhen.mat;
temp2=[];
temp1=[];
tianchong=0;%Ĭ�����0��
for i=1:flownum
    temp2=[temp2 nooptcost(flow,link,i)];
end
sumnoopt=sum(temp2);%�����Ż�ǰ����
k=round(flownum*rand());%�������k
tfcheck=zeros(1,flownum);
for i=1:k%����Ż���m���������Ż�k��
    m=1+round(k*rand());
    while(tfcheck(m)==1)
        m=1+round(k*rand());
    end
    tfcheck(m)=1;
    if(sumnoopt==0)
        [temp1,tempflow,templink]=dijoptad(flow,link,linjieLINK,nodenum,m,G,999999);
    else
        [temp1,tempflow,templink]=dijoptad(flow,link,linjieLINK,nodenum,m,G,temp2(m));
    end
    if(temp1~=-1)
        flow=tempflow;
        link=templink;
    end
end

for i=1:flownum
    temp1=[temp1 nooptcost(flow,link,i)];
end
sumopt=sum(temp1);%�����Ż����Ǯ


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
