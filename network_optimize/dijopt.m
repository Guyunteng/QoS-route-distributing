%�����������Ϊfl�����ݽ��е���·�Ż�
%�Ż�����Ϊ��Ȩ��dij��������Լ�������Ȩ��ֱ������


function [f,flo,lin]=dijopt(flow,link,linjieLINK,n,fl,GG,cost)%����Ϊ�������ṹ������ṹ��������ͨ״̬���ڵ���,���Ż������������ڻ��ѵ�Ȩֵ�����ܻ���
flo=flow;
lin=link;
s=flow{fl}.fromnode;%���
t=flow{fl}.tonode;%�յ�
temp=flow{fl}.pathnum;
bandwidth=flow{fl}.bandwidth;

%�޳�·��
for i=1:temp
    link{flow{fl}.path(i)}.unbandwidth=link{flow{fl}.path(i)}.unbandwidth+bandwidth;
end
G=GG;
for i=1:n
    for j=1:n
        if(linjieLINK(i,j)~=0)
        if(link{linjieLINK(i,j)}.unbandwidth<bandwidth)%ɾ����������ı�
            G(i,j)=999999;
        end
        end
    end
end


visit=zeros(n);%�ѷ��ʽڵ��¼
visit(s)=1;
for i=1:n
    D(i)=G(s,i);
    linkpre(i)=linjieLINK(s,i);%ÿ���ڵ��Pre��,���ڼ�¼���·��
    pre(i)=s;%ÿ���ڵ��Pre��,���ڼ�¼���·��
end
D(s)=0;

%dij�㷨
for i=1:n
    next=s;
    min=999999;
    for j=1:n
        if(visit(j)==0)
            if(D(j)<min)
                min=D(j);
                next=j;
            end
        end
    end
    visit(next)=1;
    for j=1:n
        if((D(next)+G(next,j))<D(j))
            D(j)=D(next)+G(next,j);
            pre(j)=next;
            linkpre(j)=linjieLINK(next,j);
        end
    end
end

sumdelay=0;
sumpassratio=1;
sumcost=0;
f=D(t);


%�ж��Ƿ�����Լ������
    if(D(t)~=999999)
        tempt=t;
        while(tempt~=s)
            %[fl s t linkpre(tempt)]
            sumdelay=sumdelay+link{linkpre(tempt)}.delay;
            sumcost=sumcost+link{linkpre(tempt)}.cost*bandwidth;
            sumpassratio=sumpassratio*(1-link{linkpre(tempt)}.lossratio);
            tempt=pre(tempt);
            
        end
        if (sumdelay>flow{fl}.maxdelay)
            display('delay:');display(fl);f=-1;
        else
            flow{fl}.nowdelay=sumdelay;
        end
        if (sumpassratio<1-flow{fl}.maxlossratio)
            display('loss');display(fl);f=-1;
        else
            flow{fl}.nowlossradio=1-sumpassratio;
        end
        if (sumcost>=cost)
            display('cost');display(fl);f=-1;
        else
            flow{fl}.nowcost=sumcost;
        end
    else
        display('bandwidth');display(fl);f=-1;
    end


if(f~=-1)
    %�����Ż�������Լ��
    %ɾ������������������·���ļ�¼
    for i=1:temp
        link{flow{fl}.path(i)}.flows(find(link{flow{fl}.path(i)}.flows==fl))=[];
        link{flow{fl}.path(i)}.flowsnum=link{flow{fl}.path(i)}.flowsnum-1;
    end
    flow{fl}.path=[];
    flow{fl}.pathnum=0;
    tempt=t;


    %д���µļ�¼
    while(tempt~=s)
        link{linkpre(tempt)}.flowsnum=link{linkpre(tempt)}.flowsnum+1;
        link{linkpre(tempt)}.flows=[link{linkpre(tempt)}.flows fl];
        link{linkpre(tempt)}.unbandwdith=link{linkpre(tempt)}.unbandwidth-bandwidth;
        flow{fl}.path=[flow{fl}.path linkpre(tempt)];
        flow{fl}.pathnum=flow{fl}.pathnum+1;
        tempt=pre(tempt);
    end
    flo=flow;
    lin=link;
else
    for i=1:temp
        link{flow{fl}.path(i)}.unbandwidth=link{flow{fl}.path(i)}.unbandwidth-bandwidth;
    end
end
   
    
    
end