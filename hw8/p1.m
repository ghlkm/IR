function p1()
clc;clear;
close all;
% figure(1)
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);

r=250;
xc=300;
yc=0;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

r=250;
xc=300;
yc=400;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = -r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

r=632;
xc=0;
yc=0;
t = 0 : .01 : pi/2; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);

figure(2)
mu=0;
sigma=25;
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);


%生成样本

samples_x = [];
samples_y = [];

r=250;
xc=300;
yc=0;
t = 0 : .01 : pi; 
len = size(t);
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);
samples_x = [samples_x,x];
samples_y = [samples_y,y];

xc=300;
yc=400;
t = 0 : .01 : pi; 
x = r * cos(t) + xc; 
y = -r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);
samples_x = [samples_x,x];
samples_y = [samples_y,y];

r=632;
xc=0;
yc=0;
t = 0 : .01 : pi/2; 
len = size(t);
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
x=normrnd(mu,sigma,1,len(2))+x;
y=normrnd(mu,sigma,1,len(2))+y;
plot(x, y,'.k','LineWidth',2)
plot(xc, yc,'.r','LineWidth',5);
samples_x = [samples_x,x];
samples_y = [samples_y,y];

circleplot(530,200,20,pi)
figure(3)
hold on
axis([0 600 0 400]);
set(gca,'PlotBoxAspectRatio',[6 4 1]);
m = 530;
n = 200;
sample=50;

% 对所有样本进行合并采样
% 现在样本都在samples_x, samples_y 
%{
1. 算出每个点的概率
2. sum 概率
3. normalize 概率
4. 从 pdf 到cdf
5. 生成随机数，依据随机数找样本， 这个性能可以优化， 暂时为TODO
圆心 530, 200
target f: 依据距离一维的高斯分布
%}
function f = gauss_distribution(x, mu, s)
p1 = -.5 * ((x - mu)/s) .^ 2;
p2 = (s * sqrt(2*pi));
f = exp(p1) ./ p2;
end
cx=530;cy=200;
mu=0;
s=20;
dist = ((samples_x-cx).^2+(samples_y-cy).^2).^.5;
pdf= gauss_distribution(dist, mu, s);
tmp=sum(pdf);
pdf=pdf/tmp;% normalize
% to cdf
cdf(1)=pdf(1);
for i=2:length(pdf)
    cdf(i)=cdf(i-1)+pdf(i);
end
disp(cdf(length(pdf))); % check whether is 1
disp(length(pdf)); % display how many sample
% 每次保留90%， 直到剩下50个样本
sx=[];sy=[];
cnt=1; % 1000次重采样；
while cnt>0
    for i=1:100
        r=rand();
        j=1;
        while(r>cdf(j))
           j=j+1;
        end
        sx=[sx, samples_x(j)];
        sy=[sy, samples_y(j)];
    end
    samples_x=sx;
    samples_y=sy;
    sx=[];sy=[];
    cnt=cnt-1;
end
circleplot(530,200,20,pi)
plot(samples_x, samples_y,'.r','LineWidth',5);


function circleplot(xc, yc, r, theta) 
t = 0 : .01 : 2*pi; 
x = r * cos(t) + xc; 
y = r * sin(t) + yc; 
plot(x, y,'r','LineWidth',2)
t2 = 0 : .01 : r; 
x = t2 * cos(theta) + xc; 
y = t2 * sin(theta) + yc; 
plot(x, y,'r','LineWidth',2)
end

end
