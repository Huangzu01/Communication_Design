%E4_7_Qcoe.M
function [Qb,Qa]=E5_52_Qcoe(b,a,N);
%b:ϵͳ�ķ���ϵ��
%a:ϵͳ�ķ�ĸϵ��

%[b,a]=cheby2(N,Rs,2*fc/fs) 
m=max(max(abs(a),abs(b))); %��ȡ�˲���ϵ�������о���ֵ������
Qm=floor(log2(m/a(1)));    %ȡϵ�������ֵ��a(1)��������
if Qm<log2(m/a(1))
    Qm=Qm+1;
end
Qm=2^Qm;                      %��ȡ������׼ֵ
Qb=round(b/Qm*(2^(N-1))); %���������β
Qa=round(a/Qm*(2^(N-1))); %���������β

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�Ƚ�����ǰ���˲���������Ӧ
% delta=[1,zeros(1,1023)];
% figure(1);freqz(b,a,1024,fs);
% figure(2);freqz(Qb,Qa,1024,fs);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a,b