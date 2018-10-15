function massp=mass(c,pdata,x_all,phi_all,l_all) 
n=size(x_all,2);
for j=1:n
    x=x_all(j);
    phi=phi_all(j);
    l=l_all(j);
    p=pdata{j};
    xyz=thita_r(p,c,x,phi,phi_all(1),l);
    massp{j}=xyz;
end


