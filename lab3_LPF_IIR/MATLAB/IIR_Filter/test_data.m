%test data
f1 = 1*10^6;%1MHz
f2 = 2.1 * 10^6;%2MHz
Fs = 8*10^6;%����Ƶ��Ϊ8MHz
N = 12;
Len = 2000;

t = 0:1/Fs:(Len - 1)/Fs;

s = sin(2*pi*f2*t) + sin(2*pi*f1*t);

y = round(s / max(abs(s))*(2^11-1));%12bit����

plot(t, y) 
%grid;

title('���ҵ����ź�')
xlabel('s');ylabel('��ֵ');

%b = signed2unsigned(y,N);  %ת��Ϊ�޷���������

fid = fopen('sinx.coe','w'); %д��sin.coe�ļ���������ʼ��sin_rom
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=10;\n');
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n');
for i = 1:1:2000
fprintf(fid,'%d',y(i));
if i==2000
fprintf(fid,';');
else
fprintf(fid,',');
end
if i%15==0
fprintf(fid,'\n');
end
end
fclose(fid);

