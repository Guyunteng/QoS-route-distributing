%��fl���е���·�Ż���ɾ��flռ�ÿռ䣬��fl�ļ�Ȩ���·�������������Ż�Ȩ�أ�ֱ���ҵ������������
%�Ż�����Ϊ��Ȩ��dij��������Լ�������Ȩ��ֱ������


function [f,flo,lin]=dijoptad(flow,link,linjieLINK,n,fl,GG,cost)%����Ϊ�������ṹ������ṹ��������ͨ״̬���ڵ���,���Ż������������ڻ��ѵ�Ȩֵ�����ܻ���
    f=-1;
    flo=flow;
    lin=link;
    G=GG;
%��ʼ��Ȩֵ
    a1=1;
    a2=0;
    a3=0;
    a4=0;
    
time=0;%��ʼ����������
%��ʼ����Ȩֵ
while(f==-1 && time<100)
    time=time+1;
    if(time==99)
        aaaa=0;
    end
    
        bandwidth=flow{fl}.bandwidth;

%��ʼ����ȨG
    for i=1:n
    for j=1:n
        if(linjieLINK(i,j)==0)
            G(i,j)=999999;
        else
        G(i,j)=a1/100*link{linjieLINK(i,j)}.cost+a2*link{linjieLINK(i,j)}.delay+a3*20*link{linjieLINK(i,j)}.lossratio+a4*link{linjieLINK(i,j)}.unbandwidth/flow{fl}.bandwidth;
        end
    end
end
    for i=1:n
        for j=1:n
            if(linjieLINK(i,j)~=0)
            if(link{linjieLINK(i,j)}.unbandwidth<bandwidth)%ɾ����������ı�
                G(i,j)=999999;
            end
            end
        end
    end    
    
    flo=flow;
    lin=link;
    s=flow{fl}.fromnode;
    t=flow{fl}.tonode;
    temp=flow{fl}.pathnum;
    %�޳�·��
    for i=1:temp
        link{flow{fl}.path(i)}.unbandwidth=link{flow{fl}.path(i)}.unbandwidth+bandwidth;
    end


    visit=zeros(n);%�ѷ��ʽڵ��¼
    visit(s)=1;
    for i=1:n
        D(i)=G(s,i);
        linkpre(i)=linjieLINK(s,i); %ÿ���ڵ��Pre��,���ڼ�¼���·��
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

%���������������Ȩֵ����
            if (sumcost>=cost)
               % display('cost');display(fl);
               if(a1==1)
                   break;
               end
               f=-1;
                a1=a1+a2*0.5+a3*0.5;
                a2=a2*0.5;
                a3=a3*0.5;
                
            else
                flow{fl}.nowcost=sumcost;
                if (sumdelay>flow{fl}.maxdelay && sumpassratio<1-flow{fl}.maxlossratio)
                    a2=a2+a1*0.5/3;
                    a3=a3+a1*0.5/3;
                    a4=a4+a1*0.5/3;
                    a1=a1*0.5;
                else
                    if (sumdelay>flow{fl}.maxdelay)
                       % display('delay:');display(fl);
                       f=-1;
                        a2=a2+a3*0.5;
                        a2=a2+a1*0.5;
                        a2=a2+a4*0.5;
                        a3=a3*0.5;
                        a1=a1*0.5;
                        a4=a4*0.5;
                    else
                        flow{fl}.nowdelay=sumdelay;
                        if (sumpassratio<1-flow{fl}.maxlossratio)
                            %display('loss');display(fl);
                            f=-1;
                            a3=a3+a1*0.5;
                            a3=a3+a2*0.5;
                            a3=a3+a4*0.5;
                            a2=a2*0.5;
                            a1=a1*0.5;
                            a4=a4*0.5;
                        else
                            flow{fl}.nowlossradio=1-sumpassratio;
                        end
                    end
                end
            end
        else
            %display('bandwidth');display(fl);
            f=-1;
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
end