%**************
%�������ڣ�2010.07.29
%���ܣ���.txt�ļ��ж������ݣ�������Ƶ��ͼ
%���ڸ�˹�����źž����˲�����ʾƵ��
%**************************
clear all
clc
fid = fopen('afterfir1.txt','r'); 
%fid = fopen('sinx.txt','r'); 
    for i = 1 : 4096%1024  %ע��afterfir.txt�ļ������ݲ�������1024�����ݣ���������

        num(i) = fscanf(fid, '%x',1);    %��仰����˼�Ǵ�fid��ָ���ļ���16���Ʒ�ʽ����һ�����ݡ� 

    end 

    fclose(fid); 
b = unsigned2signed(num,10);    %���޷�����ת�����з����������ʾ
%[xz,w] = freqz(b,1,512);
[xz,w] = freqz(b,1,2048);
plot(w/pi,20*log10(abs(xz)));
%plot(w/pi,20*log10(abs(xz)));