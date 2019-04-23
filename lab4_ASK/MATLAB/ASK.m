clear all
%global dt t f df N T %ȫ�ֱ���
close all 
N=2^20; 
dt=0.001; %ms 
df=1/(N*dt); %KHz 
T=N*dt; %�ض�ʱ�� 
Bs=N*df/2; %ϵͳ���� 
t=linspace(-T/2,T/2,N); %ʱ������� 
f=linspace(-Bs,Bs,N)+eps; %Ƶ������� 
fm=1; %ģ������ź�Ƶ��Ϊ1kHz 
fc=6; %�����ز��ź�Ƶ��Ϊ6kHz 
mt=cos(2*pi*fm*t); %ģ������ź� 
m(mt>0)=1;  %���ͱ���
m(mt<0)=0;
c=cos(2*pi*fc*t); %�����ز��ź� 
s=m.*c; %ASK�ѵ��ź� ��˱�ʾ���������Ӧλ��Ԫ�����
subplot(2,1,1) 
plot(t,m,'LineWidth',1.2)
title('�����ź�');
axis([-1,+1,-0.2,1.2*max(m)]) 
xlabel('t (ms)')
ylabel('s(t) (V)') 
subplot(2,1,2) 
plot(t,s,'LineWidth',1.2) 
title('2ASK���ƺ���');
axis([-1,+1,1.2*min(c),1.2*max(c)]) 
xlabel('t (ms)')
ylabel('s(t) (V)') 