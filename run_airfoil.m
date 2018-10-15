close all;
%% CST para               %0~16: P0 P1
lowerb=[-0.167016102673331,-0.112088439774085,-0.227694989662652,-0.0808472933334354,0.123130021213555,0.211976172204616,-0.0349035774624696,0.0484814157929095];
upperb=[-0.0588048660557605,0.224666750461327,0.140054634922177,0.578954273870503,0.280862229710483,0.527418007304802,0.420616563366414,0.761098697699493];
cst=[lowerb;upperb];
%distribution para
phi_0_b=[5;20];         %17
l_0_b=[5;12];           %18
phi_1_b=[15;30];        %19  
l_1_b=[12;20];          %20  
loc_lmax_b=[10;15];     %21
c_b=[0;0.65];           %22
bound=[cst,cst,phi_0_b,l_0_b,phi_1_b,l_1_b,loc_lmax_b,c_b];


% % load('sample')
% doe_2=a;
% m=size(doe_2,1);       
% distance=repmat((bound(2,:)-bound(1,:)),m,1);
% low=repmat(bound(1,:),m,1);
% doe=low+doe_2.*distance; 
 doe=a;
%% CST filter & scatter
airfoil_0_data=CST_sample_0(doe,0);
n=size(airfoil_0_data.Y,1);
for i=1:n
    k=airfoil_0_data.Y(i);
    doe_cst2(i,:)=doe(k,9:16);
end
airfoil_1_data=CST_sample_1(doe_cst2(:,1:8),1,airfoil_0_data.Y);
%% then filter£¨only negative twist£©
mm=size(airfoil_1_data.Y,1);
CST_doe_Y=[];
CST_doe_N=[];
for i=1:mm
    kk=airfoil_1_data.Y(i);
    if doe(kk,17)<doe(kk,19)
        str1=num2str(kk);
        str2='profile_Y';
        str=[str2,str1];
        e=size(CST_doe_Y,1);
        CST_doe_Y(e+1,:)=kk;
        foil_0{1,kk}=str;
        foil_0{2,kk}=airfoil_0_data.scatter{3,kk};
        foil_1{1,kk}=str;
        foil_1{2,kk}=airfoil_1_data.scatter{3,kk};
    else
        
        e=size(CST_doe_N,1);
        CST_doe_N(e+1,:)=kk;
    end
end
%% recorder
airfoil_final.Y=CST_doe_Y;
n=size(airfoil_final.Y,1);
for i=1:n
    ss=airfoil_final.Y(i);
    doe_final(i,:)=doe(ss,:);
end
airfoil_final.doe_final=doe_final;
airfoil_final.N=CST_doe_N;
airfoil_final.scatter_0=foil_0;
airfoil_final.scatter_1=foil_1;
save airfoil_final airfoil_final


%% geometry modelling (out put the .ibl documentaries which can be identified by ProE)
sac={};
n=size(CST_doe_Y,1);
for i=1:n
    ss=airfoil_final.Y(i);
    sac{1,1}=airfoil_final.scatter_1{2,ss};
    sac{1,2}=airfoil_final.scatter_1{2,ss};
    sac{1,3}=airfoil_final.scatter_0{2,ss};
    c=airfoil_final.doe_final(i,22);
    x_all=[4.45,airfoil_final.doe_final(i,21),45];
    phi_all=[airfoil_final.doe_final(i,19)/180*pi,airfoil_final.doe_final(i,19)/180*pi,airfoil_final.doe_final(i,17)/180*pi];
    l_all=[10,airfoil_final.doe_final(i,20),airfoil_final.doe_final(i,18)];
    massp=mass(c,sac,x_all,phi_all,l_all);
    mas2ibl(massp,i,sac);
    
end
