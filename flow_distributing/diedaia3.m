if(Na3<Ma)%a3������������
    if(Na3==0)
        a3=0.99999;
        a1min=0;a1max=1;Na1=0;a1=0;
        a2min=0;a2max=1;Na2=0;a2=0;
        Na3=Na3+1;
        diedaia1;
        diedaia2;
        [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
        continue;
    end
    if(a3==0.99999)
        if(flo.sumw3>flo.maxjitter)
            disp(['��3Լ��Υ����С '])
            a1=a1max;
            a2=a2max;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            weightdij;
            %flo%�޽����
            wujie=1;
            return;
        else
            %disp(['N:',num2str(N),'   a1:a2:a3  ',num2str(aa1),':',num2str(aa2),':',num2str(aa3),'     ba0:ba1:ba2:ba3  ',num2str(bb0),':',num2str(bb1),':',num2str(bb2),':',num2str(bb3)]);
            fflo=flo;
            %disp(['***'])
            a3max=a3;
            a3=0.5;%w3һ���п��н�
            a1min=0;a1max=1;Na1=0;a1=0;
            a2min=0;a2max=1;Na2=0;a2=0;
            Na3=Na3+1;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            continue;            
        end
    end
    if (flo.sumw3>flo.maxjitter)%w3�����У���Ҫ����
            a3min=a3;%a3minһ��������
            a3=(a3+a3max)/2;
            a1min=0;a1max=1;Na1=0;a1=0;
            a2min=0;a2max=1;Na2=0;a2=0;
            Na3=Na3+1;
            diedaia1;
            diedaia2;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            continue;
    else
            %disp(['N:',num2str(N),'   a1:a2:a3  ',num2str(a1),':',num2str(a2),':',num2str(a3),'     ba0:ba1:ba2:ba3  ',num2str(ba0),':',num2str(ba1),':',num2str(ba2),':',num2str(ba3)]);
            fflo=flo;
            %disp(['***'])
            a3max=a1;%a3maxһ������
            a3=(a3min+a3)/2;
            a1min=0;a1max=1;Na1=0;a1=0;
            a2min=0;a2max=1;Na2=0;a2=0;
            Na3=Na3+1;
            diedaia1;
            doedaoa2;
            [ba0 ba1 ba2 ba3]=daoshu(a1,a2,a3);
            continue;
    end
end
if(a3max~=1)
    a3=a3max;
else
    if(a3min~=0)
        disp(['��3Լ��Υ����С'])
        fflo
        wujie=1;
        return;
    end
end