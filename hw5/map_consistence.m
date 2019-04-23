% Algolrithm motion_model_velocity with Normal Distribution Noise
% 3 cases
% case 1: very large v error, very large w error
% case 2: large v error, large w error
% case 3: samll v error, very very large w error
clc 
close all
%Initial setting of mobile robot
%[x, y, theta] = deal(0);
[a1,a2,a3,a4,a5,a6] = deal(0.01, 0.01, 0.2, 0.2, 0, 0); %case 1
%[a1,a2,a3,a4,a5,a6] = deal(0.05, 0.05, 0.04, 0.04, 0, 0); %case 2
%[a1,a2,a3,a4,a5,a6] = deal(0.005, 0.005, 0, pi/6, 0, 0); %case 3
%This is an example setting, you can set it up on your own.
% 随机采样的: 维度 * 样本数, 两个时间点 
trajectory_data = zeros(3,500, 2);
% 准确路径: 维度 ，两个时间点
% 维度 x , y, theta
odom = zeros(3, 1, 2);  
%Setting the trajectory parameters
sample=@(x) x*randn();
interset=@(x, y) .5<y&&y<.6 && .6<x&&x<1.2;
r=1;
t=2;
theta=0;
delta_t=1;
[v0, w0, y0]=deal(1, 1, 0);
[v,w,y]=deal(v0, w0, y0); 
odom(1,t) = odom(1,t-1) + v/w*( -sin(theta)+sin(theta+w*delta_t));
odom(2,t) = odom(2,t-1) + v/w*( -cos(theta)+cos(theta+w*delta_t));
odom(3,t) = odom(3,t-1) + w*delta_t+y*delta_t;
tmp1=a1*v0*v0+a2*w0*w0;%v
tmp2=a3*v0*v0+a4*w0*w0;%w
tmp3=a5*v0*v0+a6*w0*w0;%y
for n=1:500
    [v,w,y]=deal(v0+sample(tmp1) ,w0+sample(tmp2), sample(tmp3));
    trajectory_data(1,n,2) = odom(1,t-1) + v/w*( -sin(theta)+sin(theta+w*delta_t));
    trajectory_data(2,n,2) = odom(2,t-1) + v/w*( cos(theta)-cos(theta+w*delta_t));
    trajectory_data(3,n,2) = odom(3,t-1) + w*delta_t+y*delta_t;
  while(interset(trajectory_data(1,n,2), trajectory_data(2,n,2)))
    [v,w,y]=deal(v0+sample(tmp1) ,w0+sample(tmp2), sample(tmp3));
    trajectory_data(1,n,2) = odom(1,t-1) + v/w*( -sin(theta)+sin(theta+w*delta_t));
    trajectory_data(2,n,2) = odom(2,t-1) + v/w*( cos(theta)-cos(theta+w*delta_t));
    trajectory_data(3,n,2) = odom(3,t-1) + w*delta_t+y*delta_t;
  end
end 
scatter(trajectory_data(1,1:500,2),trajectory_data(2,1:500,2),'.');  hold on;
%{
圆心(0, 1), line1: [0 1] 到 [0 0]
    圆弧1:半径0. 8  圆弧2: 半径1.2 
圆心2(0, 0), r2= 0.2
圆心3(cos(pi/3), 1+sin(pi/3)), r3=0.2
%}
plot([0.6 1.2 1.2 0.6 0.6],[0.5 .5 .6 .6 .5]);hold on;
axis equal
axis([0 1.2 0 1])

