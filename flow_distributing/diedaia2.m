if(Na2<Ma)%a2������������
    if(Na2==0)
        a2=0.99999;
        a1min=0;a1max=1;Na1=0;a1=0;a1=0;
        Na2=Na2+1;
        diedaia1;
        [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
        continue;
    end
    if(a2==0.99999)
        if(flo.prow2>flo.maxlossratio)
            disp(['��2Լ��Υ����С '])
            a1=a1max;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            weightdij;
            %flo%�޽����
            wujie=1;
            return;
        else
            a2max=a2;
            a2=0.5;%w1һ���п��н�
            a1min=0;a1max=1;Na1=0;a1=0;a1=0;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            Na2=Na2+1;
            continue;            
        end
    end
    if (flo.prow2>flo.maxlossratio)%w2�����У���Ҫ����
            a2min=a2;%a2minһ��������
            a2=(a2+a2max)/2;
            a1min=0;a1max=1;Na1=0;a1=0;
            Na2=Na2+1;
            diedaia1;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            continue;
    else
            a2max=a2;%a2maxһ������
            a2=(a2min+a2)/2;
            a1min=0;a1max=1;Na1=0;a1=0;
            Na2=Na2+1;
            diedaia1;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            continue;
    end
end
if(a2max~=1)
    a2=a2max;
else
    if(a2min~=0)
        disp(['��2Լ��Υ����С'])
        fflo
        wujie=1;
        return;
    end
end