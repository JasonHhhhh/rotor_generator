function mas2ibl(massp,num,pdata)
%输入某一训练点的所有散点massp元胞以及其训练点编号
%输出对应的ibl文件；文件名带有训练点的编号；
%注意：creo在识别ibl时：尽管我们用begin curve！ 将其分段，但是在同一个section下点的顺序仍然要连续！
str1=num2str(num);
str2='.ibl';
str=[str1,str2];
fid=fopen(str,'wt');%其中fid用于存储文件句柄值，如果返回的句柄值大于0，则说明文件打开成功。文件名用字符串形式，表示待打开的数据文件。
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
                fprintf(fid,'%g\n',a(78-i,j));%写入数据后换行
            else
                fprintf(fid,'%g\t',a(78-i,j));%写入数据后空格
            end
        end       %写入数据
    end
    
    
    fprintf(fid,'%s\n','begin curve!2');
    for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(2,j));%写入数据后换行
            else
                fprintf(fid,'%g\t',a(2,j));%写入数据后空格
            end
            end 
                for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(151,j));%写入数据后换行
            else
                fprintf(fid,'%g\t',a(151,j));%写入数据后空格
            end
                end   
        
fprintf(fid,'%s\n','begin curve!3');
    
    for i=71:145
        for j=1:3
            if j==3
                fprintf(fid,'%g\n',a(222-i,j));%写入数据后换行
            else
                fprintf(fid,'%g\t',a(222-i,j));%写入数据后空格
            end
        end       %写入数据
    end
  
 
        
    
     
     
     
     
end





