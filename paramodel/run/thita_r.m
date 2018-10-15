function xyz=thita_r(p,c,x,phi,phi_genbu,l)
%这样一个函数，对一个二维翼型数据进行旋转平移得到我们需要的三维数据
%p为翼型的初步散点数据
%c为旋转中心
%x为其在三维桨叶图内的径向坐标
%xyz为该翼型最终得xyz坐标
%phi安装角，l:弦长 %phi_genbu
n=size(p,1);
p=p-repmat([c,0],n,1);
xyz=zeros(n,3);
for i=1:n
    [th,r]=cart2pol(p(i,1),p(i,2));
    th=th-phi;
    r=r*l;
    [a1,b1]=pol2cart(th,r);
    xyz(i,1)=x;
    xyz(i,2)=a1+(c-0.5)*10*cos(phi_genbu);
    xyz(i,3)=b1;
end
