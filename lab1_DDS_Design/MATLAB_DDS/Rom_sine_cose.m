x=linspace(0,2*pi,4096);%6.28Ϊ2pi��һ�����ڲ�����ȡ4096��
y1=cos(x)+1;    %������ƽ�Ƶ�����������ᡣ
y2=sin(x)+1;
y3=ceil(y1*511);
y4=ceil(y2*511);

%����cos����coe�ļ�
fid = fopen('cos.txt','wt');
%fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
%fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
%fprintf(fid,'%16.0f\n',y3);
for i = 1:1:2^12
    fprintf(fid,'%x',y3(i));
    if i==2^12
        fprintf(fid,';');
    %else
    %    fprintf(fid,',');
    end
    if i%15==0
        fprintf(fid,'\n');
    end
end
fclose(fid);

%����sin����coe�ļ�
fid = fopen('sin.txt','wt');
%fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
%fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
    fprintf(fid,'%x',y4(i));
    if i==2^12
        fprintf(fid,';');
    %else
    %    fprintf(fid,',');
    end
    if i%15==0
        fprintf(fid,'\n');
    end
end
fclose(fid);

%���ɷ���
t=1:1:2^12;
y=(t<=2047);
r=ceil(y*(2^9-1));
fid = fopen('square.txt','w'); %д��square.coe��������ʼ��rom_square
%fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
%fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
fprintf(fid,'%x',r(i));
if i==2^12
fprintf(fid,';');
%else
%fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);
%�������ǲ�
t=1:1:2^12;
y=[0.5:0.5/1024:1-0.5/1024, 1-0.5/1024:-0.5/1024:0, 0.5/1024:0.5/1024:0.5];
r=ceil(y*(2^9-1));
fid = fopen('triangular.txt','w'); %д��triangular.coe����ʼ�����ǲ�rom
%fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
%fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2^12
fprintf(fid,'%x',r(i));
if i==2^12
fprintf(fid,';');
%else
%fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);
