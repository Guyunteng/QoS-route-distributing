%���ѡȡK��������������������������޳�K�����������Ӵ���󵽴���С���η���
%�Ż�����Ϊ��Ȩֵ��dij

sumopt=0;
sumnoopt=0;
%clear all;load chushijuzhen.mat;
temp2=[];
temp1=[];
tianchong=0;
for i=1:flownum
    temp2=[temp2 nooptcost(flow,link,i)];

end
    sumnoopt=sum(temp2);

%���������k�����ݣ��˴�Ϊw1~w2)
w1=round(flownum*rand())
w2=w1+round((flownum-w1)*rand())
ffn=w2-w1
a={};
b={};
for i=1:(w2-w1)
    a{i}=flow{i+w1}.id;
    b{i}=flow{i+w1}.bandwidth;
end

%��k�����������Ŵ���a
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


%���ź�����������б�a�����Ż�����
    if(sumnoopt==0)
        [temp1,tempflow,templink]=dijoptad2(flow,link,linjieLINK,nodenum,a,G,999999);
    else
        [temp1,tempflow,templink]=dijoptad2(flow,link,linjieLINK,nodenum,a,G,temp2(a{i}));
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


