function [flo qiangzhan]=jisuan(flows,Map,link,linjieLINK,Mapcost,Mapw1,Mapw2,Mapw3)
    global nodenum
    global lidu
    n=nodenum;
    global M
    global linknum
    global flowsnum
    global flow_q
    queue_first=flow_q(1);
    Q=[];%��ռ��ʱ�޳�����
    fenliu=0;
    qiangzhan=[];
    
    %Ѱ����󻨷�%
    maxcost=0;
    for i=1:linknum
        if (maxcost<link{i}.cost)
            maxcost=link{i}.cost;
        end
    end
    %%%%%%%%%%%%%

    tic
    %%%%%%%%%%�����ռ%%%%%%%%%%
    for i=1:flowsnum
        if (flows{i}.rank<queue_first.rank)
            if (flows{i}.bandwidth==0)
                continue
            end
            Q=[Q i];%������ʱ
            for j=1:length(flows{i}.path)
                needdel=flows{i}.path(j);
                link{needdel}.restbandwidth=link{needdel}.restbandwidth+flows{i}.bandwidth;
                link{needdel}.cost=link{needdel}.cost+maxcost;
                Mapcost(link{needdel}.fromnode,link{needdel}.tonode)=link{needdel}.cost;
            end
        end
    end
    for i=1:linknum
        Mapbw(link{i}.fromnode,link{i}.tonode)=link{i}.restbandwidth;
    end 
    
    %������ͨ���ж�%
    liantong=0;
    Map=Mapcost;
    for i=1:n
        for j=1:n
            if (Map(i,j)==0 || Mapbw(i,j)<queue_first.bandwidth)
                Map(i,j)=999999;
            end
        end
    end
    [f,flo,lin]=dij(queue_first,Map,link,linjieLINK);  
    if(flo.pathnum<1)
        disp(['�����ռ����Ȼ��������'])
        fenliu=1;
    end
    %%%%%%%%%%%%%%%
    etime=toc;
    disp(['��ռ��ʱ��',num2str(etime),'s'])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
     
    
    
    %%%%%%%%%%%���%%%%%%%%%%%%
    if (fenliu==0)
        youjie=0;
        tic
        qiujienew
        for i=1:length(flo.path)
            link{flo.path(i)}.restbandwidth=link{flo.path(i)}.restbandwidth-flo.bandwidth;
        end
        if (youjie==0)
            return;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%   
    
    
    
    %%%%%%%%%%%�ָ���ռ��ִ�з���%%%%%%%%%%
    if (fenliu==1)
        tic
        for i=1:length(Q)
            for j=1:length(flows{Q(i)}.path)
                needadd=flows{Q(i)}.path(j);
                link{needadd}.restbandwidth=link{needadd}.restbandwidth-flows{Q(i)}.bandwidth;
                link{needadd}.cost=link{needadd}.cost-maxcost;
            end
        end
        flow_q(1)=[];
        mintempbw=lidu*floor(queue_first.bandwidth/lidu/2);
        if(mintempbw==0)
            disp(['�ѷ�������С���ȣ��޽�'])
            return
        end
        if(queue_first.div>2)%��������������Ϊ2
            disp(['�ѳ�������������'])
            return;
        else
            tempflo=queue_first;
            tempflo.bandwidth=mintempbw;
            tempflo.div=queue_first.div+1;
            flow_q=[flow_q tempflo];
            tempflo.bandwidth=queue_first.bandwidth-mintempbw;
            flow_q=[flow_q tempflo];
            etime=toc;
            disp(['������ʱ��',num2str(etime),'s'])
            return;            
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    
    %%%%%%%%%%%%%�ָ���ռ�����޷��ָ��ļ������%%%%%%%%%%%%%
    tic
    sumlost=0;
    for i=1:length(Q)
        norecover=0;
        for j=1:length(flows{Q(i)}.path)
            needadd=flows{Q(i)}.path(j);
            if(link{needadd}.restbandwidth<flows{Q(i)}.bandwidth)
                norecover=1;%���ָܻ�
                break;
            end
        end
        if(norecover==0)%���Իָ�
            for j=1:length(flows{Q(i)}.path)
                needadd=flows{Q(i)}.path(j);
                link{needadd}.restbandwidth=link{needadd}.restbandwidth-flows{Q(i)}.bandwidth;
                link{needadd}.cost=link{needadd}.cost-maxcost;
            end
        else
            sumlost=sumlost+1;
            flow_q=[flow_q flows{Q(i)}];
            qiangzhan=[qiangzhan Q(i)];
        end
    end
    disp(['��',num2str(sumlost),'������ռ'])
    etime=toc;
    disp(['�ָ���ռ��ʱ��',num2str(etime),'s'])
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end