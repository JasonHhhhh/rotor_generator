function mas2ibl(massp,num,pdata)
%����ĳһѵ���������ɢ��masspԪ���Լ���ѵ������
%�����Ӧ��ibl�ļ����ļ�������ѵ����ı�ţ�
%ע�⣺creo��ʶ��iblʱ������������begin curve�� ����ֶΣ�������ͬһ��section�µ��˳����ȻҪ������
str1=num2str(num);
str2='.ibl';
str=[str1,str2];
fid=fopen(str,'wt');%����fid���ڴ洢�ļ����ֵ��������صľ��ֵ����0����˵���ļ��򿪳ɹ����ļ������ַ�����ʽ����ʾ���򿪵������ļ���
fprintf(fid,'%s\n','Open Arclength');
m=size(massp,2);
for k=1:m
    fprintf(fid,'%s','begin section!');
    fprintf(fid,'%s\n',num2str(k));
    fprintf(fid,'%s\n','begin curve!1');
    a=massp{k};
    
    

    for i=2:76
        for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(78-i,j));%д�����ݺ���
            else
                fprintf(fid,'%g\t',a(78-i,j));%д�����ݺ�ո�
            end
        end       %д������
    end
    
    
    fprintf(fid,'%s\n','begin curve!2');
    for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(2,j));%д�����ݺ���
            else
                fprintf(fid,'%g\t',a(2,j));%д�����ݺ�ո�
            end
            end 
                for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(151,j));%д�����ݺ���
            else
                fprintf(fid,'%g\t',a(151,j));%д�����ݺ�ո�
            end
                end   
        
fprintf(fid,'%s\n','begin curve!3');
    
    for i=71:145
        for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(222-i,j));%д�����ݺ���
            else
                fprintf(fid,'%g\t',a(222-i,j));%д�����ݺ�ո�
            end
        end       %д������
    end
  
 
        
    
     
     
     
     
end





