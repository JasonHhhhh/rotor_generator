function xyz=thita_r(p,c,x,phi,phi_genbu,l)
%����һ����������һ����ά�������ݽ�����תƽ�Ƶõ�������Ҫ����ά����
%pΪ���͵ĳ���ɢ������
%cΪ��ת����
%xΪ������ά��Ҷͼ�ڵľ�������
%xyzΪ���������յ�xyz����
%phi��װ�ǣ�l:�ҳ� %phi_genbu
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
