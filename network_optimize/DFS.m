%����������������������з���


clear all
load aaa.mat
tianchong=0;
for i=1:flownum
    tf=zeros(nodenum,nodenum);
    pre=zeros(1,linknum);
    fn=flow{i}.fromnode;
    tn=flow{i}.tonode;
    topP=0; %ջ��Pָ��
    lastlink=0; %ǰ�νڵ�
    pre=zeros(1,linknum);
    jishuqi=0;
    while(1==1)
        jishuqi=jishuqi+1;
        for j=1:nodenum
            nocircle=0; %�ж��Ƿ���ѭ��
            if (linjie(fn,j)~=0 && tf(fn,j)==0) %�����Ƿ��ڶ����У��Ƿ���ͨ                
                if (lastlink==0)
                    check=0;
                else
                    check=lastlink;
                end
                
                while(check~=0)
                    if (link{check}.tonode==link{linjieLINK(fn,j)}.tonode)
                        nocircle=1;
                        break
                    end
                    check=pre(check);
                end
                if (nocircle==0)
                    topP=topP+1;
                    P(topP)=linjieLINK(fn,j); %��ջP
                    tf(fn,j)=1;
                    pre(P(topP))=lastlink; %��Ǹ���
                end
              
            end
        end
        if(topP==0)
            break;
        end
        fn=link{P(topP)}.tonode;
        lastlink=P(topP); %����ǰ�νڵ�
        tf(link{P(topP)}.fromnode,link{P(topP)}.tonode)=0; %��ǻ�ԭ
        topP=topP-1; %��ջ
        if (topP==0 && link{lastlink}.fromnode~=flow{i}.fromnode)
            break;
        end
        if (fn==tn) %��ʼ���Լ������
            sumdelay=0;% ���ӳٳ�ʼ��
            sumpassratio=1; %�ܴ����ʳ�ʼ��
            cost=0;%��ʼ��Ǯ
            check=P(topP+1);
            checkright=0;
            while(link{check}.unbandwidth>=flow{i}.bandwidth && sumdelay<=flow{i}.maxdelay && sumpassratio>1-flow{i}.maxlossratio)
                sumdelay=sumdelay+link{check}.delay;
                sumpassratio=sumpassratio*(1-link{check}.lossratio);
                cost=cost+link{check}.cost*flow{i}.bandwidth;
                check=pre(check);
                if (check==0)
                    checkright=1;
                    flow{i}.nowdelay=sumdelay;
                    flow{i}.nowlossratio=1-sumpassratio;
                    flow{i}.nowcost=cost;
                    break
                end
            end
            if (checkright==1)
                break;
            else
                %������
                if (topP==0)
                    break
                end;
                fn=link{P(topP)}.tonode;
                lastlink=P(topP); %����ǰ�νڵ�
                tf(link{P(topP)}.fromnode,link{P(topP)}.tonode)=0; %��ǻ�ԭ
                topP=topP-1; %��ջ 
            end
        end
    end
    if(checkright==1)
        check=P(topP+1);
        tianchong=tianchong+1;
        while(check~=0)
            flow{i}.pathnum=flow{i}.pathnum+1;
            flow{i}.path(flow{i}.pathnum)=check;
            link{check}.flowsnum=link{check}.flowsnum+1;
            link{check}.flows(link{check}.flowsnum)=i;
            link{check}.unbandwidth=link{check}.unbandwidth-flow{i}.bandwidth;
            check=pre(check);
        end
    end
end