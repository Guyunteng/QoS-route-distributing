clear all
load chushijuzhen.mat
nowtime=datestr(now,30)
save(nowtime)
global flow_q
global M
n=nodenum;
M=10000;
N=1;
global jishu;
jishu=0;
flow_q=[];
flow_q=[flow_q flow];
allans=[];

while(length(flow_q)~=0)
    jishu=jishu+1;
    fprintf('\n\n��%d���\n������ȫ�����ݣ�%s\n', jishu,num2str([flow_q.bandwidth]))
    disp(['��ǰ�������ݣ�',num2str(flow_q(1).bandwidth)])
    [flo qiangzhan]=jisuan(flows,Map,link,linjieLINK,Mapcost,Mapw1,Mapw2,Mapw3);
    l=length(qiangzhan);
    for i=1:l%��ԭ����ռ������
        ll=length(flows{i}.path);
        for k=1:ll
            link{flows{i}.path(k)}.restbandwidth=link{flows{i}.path(k)}.restbandwidth+flows{i}.bandwidth;
        end
        flows{i}.bandwidth=0;%ɾ���������Ѵ�������������    
    end
    l=length(flo.path);
    for i=1:l
        link{flo.path(i)}.restbandwidth=link{flo.path(i)}.restbandwidth-flo.bandwidth;
    end
    allans=[allans flo];
    fprintf('realcost:%f\n',flo.realcost);
end
save([nowtime 'ans'])