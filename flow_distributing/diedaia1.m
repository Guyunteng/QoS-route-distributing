if(Na1<Ma)%a1������������
    if(Na1==0)
        a1=0.99999;
        [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
        Na1=Na1+1;
        continue;
    end
    if(a1==0.99999)
        if(flo.sumw1>flo.maxdelay)
            disp(['��1Լ��Υ����С'])
            %flo%�޽����
            wujie=1;
            return;
        else
            a1max=a1;
            a1=0.5;%w1һ���п��н�
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            Na1=Na1+1;
            continue;            
        end
    end
    if (flo.sumw1>flo.maxdelay)%w1�����У���Ҫ����
            a1min=a1;%a1minһ��������
            a1=(a1+a1max)/2;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            Na1=Na1+1;
            continue;
    else%w1����
            a1max=a1;%a1maxһ������
            a1=(a1min+a1)/2;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            Na1=Na1+1;
            continue;
    end
end
if(a1max~=1)
    a1=a1max;
else
    if(a1min~=0)
        disp(['��1Լ��Υ����С'])
        fflo
        wujie=1;
        return;
    end
end