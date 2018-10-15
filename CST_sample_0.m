function airfoil_0_data=CST_sample_0(doe_w,num)
%input:doe_w: design of experiment matrix 
%      num  : 0 or 1 which represents the tip or root airfoil   

dz=0.003;
N=150;
%initialization
CST_doe_Y=[];
CST_doe_N=[];
nn=size(doe_w,1);
doe=doe_w;
for i=1:nn
    close all;
    p=doe(i,:);
    
   %% Airfoil caculator%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s=p(3)*0.0294+p(4)*0.9703-p(7)*0.0294-p(8)*0.9703;
    [zerind,coord] = CST_airfoil(p(1:4),p(5:8),dz,N);
    %%plot the airfoil and record all
    for_ibl=[coord(1:zerind,1),coord(1:zerind,2);coord(zerind:N,1),coord(zerind:N,2)];
    plot(coord(1:zerind,1),coord(1:zerind,2));
    hold on
    plot(coord(zerind:N,1),coord(zerind:N,2));
    axis equal
    
    %%  % N1 N1 WL WU(some parameters)
    N1 = 0.4703;
    N2 = 1.0330;
    w=p;
    wl=w(1:4);
    wu=w(5:8);
    %%  %%  tmax loc_max
    t=@(x)(-CST_inputx_t(wl,wu,x,N1,N2));
    [loc_tmax, tmax]=fmincon(t,0,[],[],[],[],0,1);
    %% cam_max loc_cam_max
    mid=@(x)(-CST_camber_mid(wl,wu,x,N1,N2));
    [loc_cam_max, cam_max]=fmincon(mid,0,[],[],[],[],0,1);
    %% find the f'=0 of upper and lower airfoil curve
    syms v
    yup=cst_y(v,wu,N1,N2);
    yyup=diff(yup);
    v=0.0001;
    yyu=eval(yyup);
    syms o
    ylo=cst_y(o,wl,N1,N2);
    yylo=diff(ylo);
    o=0.001;
    yyl=eval(yylo);
    angle_0=atan(abs((yyl-yyu)/(1+yyl*yyu)))*180/pi;
    
    %% find the thickness' = 0 point
    syms v
    thickness=CST_inputx_t(wl,wu,v,N1,N2);
    dt=diff(thickness);
    f=@(v)eval(dt);
    %%find all zero points
    for d=1:100
        v=0.01*d;
        h=fsolve(f,v);
        if d==1
            xzeros(d)=h;
        else
            n=size(xzeros,1);
            hh=xzeros(n);
            if h-hh>0.15 && h<0.99 && h>0.01
                xzeros(n+1)=h;
            else
            end
        end
    end
    
    %% constraints %%
    
    str1=num2str(i);
    str2='airfoil';
    str3=[str2,str1];
    %%1 coding
    pp{1,i}=str3;
    %%2 save the para
    pp{2,i}=p;
    %%3 
    pp{3,i}=[loc_tmax, tmax];
    %%4 
    pp{4,i}=[loc_cam_max, cam_max];
    %%5 thickness on 0.6r 0.65r 0.7r  
    pp{5,i}=[0.6 0.65 0.75;t(0.6),t(0.65),t(0.7)];
    %%6 
    pp{6,i}=xzeros;
    %%7 
    pp{7,i}=angle_0;
    

    
    
    %% %CST_doe_Y/N recorder %% 
    
    if s<0
        if loc_tmax<0.425
            if tmax<-0.067
                if t(0.65)<-0.02
                    
                    str2='profile_Y';
                    str=[str2,str1];
                    e=size(CST_doe_Y,1);
                    CST_doe_Y(e+1,:)=i;
                    foil{1,i}=str;
                    foil{2,i}=zerind;
                    foil{3,i}=for_ibl;
                    
                else
                    str2='profile_N';
                    str=[str2,str1];
                    e=size(CST_doe_N,1);
                    CST_doe_N(e+1,:)=i;
                end
            else
                str2='profile_N';
                str=[str2,str1];
                e=size(CST_doe_N,1);
                CST_doe_N(e+1,:)=i;
            end
        else
            str2='profile_N';
            str=[str2,str1];
            e=size(CST_doe_N,1);
            CST_doe_N(e+1,:)=i;
        end
    else
        str2='profile_N';
        str=[str2,str1];
        e=size(CST_doe_N,1);
        CST_doe_N(e+1,:)=i;
        
    end
    
    F=getframe(gcf); 
    F1=getframe;     
    % //======save the pictures=========
    % //mkdir([cd,'/image']) 
    %save outcomes
    eval(['mkdir section',num2str(num),';']);
    directory=[cd,['/section',num2str(num),'/']];
    imwrite(F.cdata,[directory,[str,'.png']]);
    %// imwrite(F.cdata,'image/test1.png') 
    %imwrite(F1.cdata,[directory,'test2.png'])
    
    
end
%% % save the filter outcomes as a structure
airfoil_0_data.doe=doe;
airfoil_0_data.all_points=pp;
airfoil_0_data.Y=CST_doe_Y;
airfoil_0_data.N=CST_doe_N;
airfoil_0_data.scatter=foil;
eval(['save airfoil_data_',num2str(num),' airfoil_0_data'] )

