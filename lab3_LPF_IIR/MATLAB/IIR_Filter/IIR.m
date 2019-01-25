% IIR�˲������
% Ŀ�ģ����һ������Ƶ��Ϊ1000Hz��ͨ����ֹƵ��Ϊ50Hz�������ֹƵ��Ϊ100Hz�ĵ�ͨ�˲�������Ҫ��ͨ�����˥��Ϊ1dB�������С˥��Ϊ60dB��

clc;clear;close all;

% 1. �����źţ�Ƶ��Ϊ10Hz��100Hz�����Ҳ����ӣ�
Fs=1000; % ����Ƶ��1000Hz
t=0:1/Fs:1;
s10=sin(20*pi*t); % ����10Hz���Ҳ�
s100=sin(200*pi*t); % ����100Hz���Ҳ�
s=s10+s100; % �źŵ���

figure(1); % ��ͼ
subplot(2,1,1);plot(s);grid;
title('ԭʼ�ź�');

% 2. FFT�����ź�Ƶ��
len = 512;
y=fft(s,len);  % ���ź���len��FFT�任
f=Fs*(0:len/2 - 1)/len;

subplot(2,1,2);plot(f,abs(y(1:len/2)));grid;
title('ԭʼ�ź�Ƶ��')
xlabel('Hz');ylabel('��ֵ');

% 3. IIR�˲������
N=0; % ����
Fp=50; % ͨ����ֹƵ��50Hz
Fc=100; % �����ֹƵ��100Hz
Rp=1; % ͨ���������˥��Ϊ1dB
Rs=60; % ���˥��Ϊ60dB

% 3.0 ������С�˲�������
na=sqrt(10^(0.1*Rp)-1);
ea=sqrt(10^(0.1*Rs)-1);
N=ceil(log10(ea/na)/log10(Fc/Fp));

% 3.1 ������˹�˲���
Wn=Fp*2/Fs;
[Bb Ba]=butter(N,Wn,'low'); % ����MATLAB butter������������˲���
[BH,BW]=freqz(Bb,Ba); % ����Ƶ����Ӧ����
Bf=filter(Bb,Ba,s); % ���е�ͨ�˲�
By=fft(Bf,len);  % ���ź�f1��len��FFT�任

figure(2); % ��ͼ
subplot(2,1,1);plot(t,s10,'blue',t,Bf,'red');grid;
legend('10Hzԭʼ�ź�','������˹�˲����˲���');
subplot(2,1,2);plot(f,abs(By(1:len/2)));grid;
title('������˹��ͨ�˲����ź�Ƶ��');
xlabel('Hz');ylabel('��ֵ');

% 3.2 �б�ѩ��I���˲���
[C1b C1a]=cheby1(N,Rp,Wn,'low'); % ����MATLAB cheby1����������Ƶ�ͨ�˲���
[C1H,C1W]=freqz(C1b,C1a); % ����Ƶ����Ӧ����
C1f=filter(C1b,C1a,s); % ���е�ͨ�˲�
C1y=fft(C1f,len);  % ���˲����ź���len��FFT�任

figure(3); % ��ͼ
subplot(2,1,1);plot(t,s10,'blue',t,C1f,'red');grid;
legend('10Hzԭʼ�ź�','�б�ѩ��I���˲����˲���');
subplot(2,1,2);plot(f,abs(C1y(1:len/2)));grid;
title('�б�ѩ��I���˲����ź�Ƶ��');
xlabel('Hz');ylabel('��ֵ');

% 3.3 �б�ѩ��II���˲���
[C2b C2a]=cheby2(N,Rs,Wn,'low'); % ����MATLAB cheby2����������Ƶ�ͨ�˲���
[C2H,C2W]=freqz(C2b,C2a); % ����Ƶ����Ӧ����
C2f=filter(C2b,C2a,s); % ���е�ͨ�˲�
C2y=fft(C2f,len);  % ���˲����ź���len��FFT�任

figure(4); % ��ͼ
subplot(2,1,1);plot(t,s10,'blue',t,C2f,'red');grid;
legend('10Hzԭʼ�ź�','�б�ѩ��II���˲����˲���');
subplot(2,1,2);plot(f,abs(C2y(1:len/2)));grid;
title('�б�ѩ��II���˲����ź�Ƶ��');
xlabel('Hz');ylabel('��ֵ');

% 3.4 ��Բ�˲���
[Eb Ea]=ellip(N,Rp,Rs,Wn,'low'); % ����MATLAB ellip����������Ƶ�ͨ�˲���
[EH,EW]=freqz(Eb,Ea); % ����Ƶ����Ӧ����
Ef=filter(Eb,Ea,s); % ���е�ͨ�˲�
Ey=fft(Ef,len);  % ���˲����ź���len��FFT�任

figure(5); % ��ͼ
subplot(2,1,1);plot(t,s10,'blue',t,Ef,'red');grid;
legend('10Hzԭʼ�ź�','��Բ�˲����˲���');
subplot(2,1,2);plot(f,abs(Ey(1:len/2)));grid;
title('��Բ�˲����ź�Ƶ��');
xlabel('Hz');ylabel('��ֵ');

% 3.5 yulewalk�˲���
fyule=[0 Wn Fc*2/Fs 1]; % �ڴ˽��е��Ǽ���ƣ�ʵ����Ҫ��η���ȡ���ֵ
myule=[1 1 0 0]; % �ڴ˽��е��Ǽ���ƣ�ʵ����Ҫ��η���ȡ���ֵ
[Yb Ya]=yulewalk(N,fyule,myule); % ����MATLAB yulewalk����������Ƶ�ͨ�˲���
[YH,YW]=freqz(Yb,Ya); % ����Ƶ����Ӧ����
Yf=filter(Yb,Ya,s); % ���е�ͨ�˲�
Yy=fft(Yf,len);  % ���˲����ź���len��FFT�任

figure(6); % ��ͼ
subplot(2,1,1);plot(t,s10,'blue',t,Yf,'red');grid;
legend('10Hzԭʼ�ź�','yulewalk�˲����˲���');
subplot(2,1,2);plot(f,abs(Yy(1:len/2)));grid;
title('yulewalk�˲����ź�Ƶ��');
xlabel('Hz');ylabel('��ֵ');

% 4. �����˲����ķ�Ƶ��Ӧ�Աȷ���
A1 = BW*Fs/(2*pi);
A2 = C1W*Fs/(2*pi);
A3 = C2W*Fs/(2*pi);
A4 = EW*Fs/(2*pi);
A5 = YW*Fs/(2*pi);

figure(7); % ��ͼ
subplot(1,1,1);plot(A1,abs(BH),A2,abs(C1H),A3,abs(C2H),A4,abs(EH),A5,abs(YH));grid;
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
legend('butter','cheby1','cheby2','ellip','yulewalk');