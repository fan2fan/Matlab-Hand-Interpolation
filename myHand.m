clc; clear all; close all;
%% A Program for my hand
load('myHand.mat');
figure(1);
x1 = 2*max(x) - x;
plot(x,y);
hold on;
plot(x1,y,'Color',[0,0.45,0.74]);
title('My Hands'); grid on;

%Interpolation- spline
figure(2)
n = length(x);
s = (1:n)';
t = (1:.05:n)';
u = splinetx(s,x,t);
v = splinetx(s,y,t);
clf reset;
hold on;
plot(u,v,'-','Color',[0,0.45,0.74])
plot(x,y,'k.');
u2 = 2*max(u) - u;
plot(u2,v,'-','Color',[0,0.45,0.74])
plot(x1,y,'k.');
title('My Hands - Spline'); grid on;

figure(3)
%Interpolation- pchip
u3 = pchiptx(s,x,t);
v3 = pchiptx(s,y,t);
clf reset;
hold on;
plot(u3,v3,'-','Color',[0,0.45,0.74])
plot(x,y,'k.');
u4 = 2*max(u3) - u3;
plot(u4,v3,'-','Color',[0,0.45,0.74])
plot(x1,y,'k.');
title('My Hands - Pchip'); grid on;

%���������������ֱ������ת��Ϊ���������в�ֵ
x1 = x - max(x); y1 = y; %����ԭ��
theta = atan2(y1,x1); r = sqrt(x1.^2+y1.^2);
n = length(theta);
s = (1:n)';t = (1:.05:n)';
u = splinetx(s,theta,t);
v = splinetx(s,r,t);
u1 = pchiptx(s,theta,t);
v1 = pchiptx(s,r,t);
%���Ʋ�ֵǰ����
figure(4)
polar(theta,r);hold on;
polar(pi-theta,r);title('Origin Polar');axis([-1 1 0 1.15]);
%����spline����
figure(5)
polar(u,v); hold on; polar(theta,r,'k.');hold on;
polar(pi-u,v); hold on; polar(pi-theta,r,'k.');
title('Spline Polar');axis([-1 1 0 1.15]);
%��������ת��Ϊֱ������
figure(6)
hold on;plot(x,y,'.');plot(v.*cos(u)+max(x),v.*sin(u),'-');
plot(2*max(x)-x,y,'.');plot(v.*cos(pi-u)+max(x),v.*sin(pi-u),'-');
title('Spline Cart');grid on;

%����Pchip����
figure(7)
polar(u1,v1); hold on; polar(theta,r,'k.');hold on;
polar(pi-u1,v1); hold on; polar(pi-theta,r,'k.');
title('Pchip Polar');axis([-1 1 0 1.15]);

figure(8)
hold on;plot(x,y,'.');plot(v1.*cos(u1)+max(x),v1.*sin(u1),'-');
plot(2*max(x)-x,y,'.');plot(v1.*cos(pi-u1)+max(x),v1.*sin(pi-u1),'-');
title('Pchip Cart');grid on;
%��ֱ��ͨ��theta��r���в�ֵ�������
%����ԭ�㣺
% ͨ��ʵ�����֪��ֱ��ʹ��spline��pchip���ܵõ���ȷ�Ľ������˲��÷ֶβ�ֵ��
% �����Լ�Ӱ����spline��pchip��ֵ
% ��Ӧ�������У�1:12, 13:20, 21:30, 31:39, 40:47, 48:58, 59:67, 68:74, 75:80, 81:89
x2 = []; y2 = []; theta = []; r = []; t = []; p = []; s = [];
I = {1:12, 13:20, 21:30, 31:39, 40:47, 48:58, 59:67, 68:74, 75:80, 81:89};
for i = 1:10
    x2_temp = x(cell2mat(I(i))) - max(x); y2_temp = y(cell2mat(I(i)));
    theta_temp = atan2(y2_temp,x2_temp);
    r_temp = sqrt(x2_temp.^2+y2_temp.^2);
    t_temp = linspace(theta_temp(1),theta_temp(end),100).';
    p_temp = pchip(theta_temp,r_temp,t_temp);
    s_temp = spline(theta_temp,r_temp,t_temp);
    x2 = [x2;x2_temp]; y2 = [y2;y2_temp]; r = [r;r_temp]; theta = [theta;theta_temp];
    t = [t;t_temp]; p = [p;p_temp];s = [s;s_temp];
end

%interpolation-spline
%�ڼ������л��Ʋ�ֵǰ��ͼ��
figure(9)
polar(theta,r);
hold on;
po = polar(pi-theta,r);set(po,'Color',[0,0.45,0.74]);
title('Origin Polar');axis([-1 1 0 1.15]);

%�ڼ������л��Ʋ�ֵ���ͼ��
figure(10)
polar(theta,r,'o');hold on;polar(t,s,'-');
hold on;polar(pi-theta,r,'o');hold on;polar(pi-t,s,'-');
title('Spline Polar');grid on;axis([-1 1 0 1.15]);

%��ֱ�������л���
figure(11)
hold on;plot(x2,y2,'o');plot(s.*cos(t),s.*sin(t),'-');
plot(-x2,y2,'o');plot(s.*cos(pi-t),s.*sin(pi-t),'-');
title('Spline Cart');grid on;

%interpolation-spline
%�ڼ������л���pchip��ֵ���ͼ��
figure(12)
polar(theta,r,'o');hold on;polar(t,p,'-');
hold on;polar(pi-theta,r,'o');hold on;polar(pi-t,p,'-');
title('Pchip Polar');grid on;axis([-1 1 0 1.15]);

%��ֱ�������л���
figure(13)
hold on;
plot(x2,y2,'o');plot(p.*cos(t),p.*sin(t),'-');
plot(-x2,y2,'o');plot(p.*cos(pi-t),p.*sin(pi-t),'-');
title('Pchip Cart');grid on;