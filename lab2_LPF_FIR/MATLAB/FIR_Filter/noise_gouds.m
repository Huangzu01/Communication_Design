% ��˹������
noise = wgn(1000, 1, 0);% ����1000*1����˹������������Ϊ0dBW���ֱ��ߣ�
%sort_noise = sort(noise);
y1 = fft(noise, 1000);%������ĸ���1000��
p1 = y1.*conj(y1);%���ʣ���ֵΪabs(1))
ff = 0:499;
stem(ff, p1(1:500));
xlabel('Ƶ��');
ylabel('����');
title('������');

mean_value = mean(noise)
variance = var(noise)
figure;
hist(noise, 20);
xlabel('��ֵ');
ylabel('Ƶ��');
title('������ֵ��ֱ��ͼ');