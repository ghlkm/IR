% Algolrithm motion_model_odometry with Normal Distribution Noise 
clc 
close all
%Initial setting of mobile robot
%[x, y, theta] = deal(0);
[a1, a2,a3,a4] = deal(0.01, 0.0002, 0.01, 0.0002);
%This is an example setting, you can set it up on your own.
% 随机采样的: 维度 * 样本数 * 时间片
trajectory_data = zeros(3,500,30);
% 准确路径: 维度 * 时间片
% 维度 x , y, theta
odom = zeros(3,30); 
odom(:,:) = NaN; 
% 前 3 秒所有维度都 置为 0
odom(:,1:3)= 0; 
trajectory_data(:,:,:) = NaN;
% 测量的不确定性， 前 1 秒 所有维度都 置为 0
trajectory_data(:,:,1:2) = 0; 
n = 1;
% t 是时间
t = 2; 
%Setting the trajectory parameters
sample=@(x) x*randn(); 
[delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, 0); 
while (t <= 30 )  
    
t = t + 1;
if t < 10          
    [delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, 0);       
elseif (t >= 10)&&(t < 12)     
    [delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, pi/4);     
elseif (t >= 12)&&(t < 20) 
    [delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, 0); 
elseif (t >= 20)&&(t < 22) 
    [delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, pi/4);
elseif (t >= 22)&&(t <= 31)     
    [delta_rot1,delta_trans,delta_rot2]=deal(0 ,50, 0);  
end 
odom(1,t) = odom(1,t-1) + delta_trans * cos(odom(3,t-1)  + delta_rot1); 
odom(2,t) = odom(2,t-1) + delta_trans * sin(odom(3,t-1)  + delta_rot1); 
odom(3,t) = odom(3,t-1) + delta_rot1 + delta_rot2; 
for n = 1: 500 
% Do your sampling    
    % x, y , theta
    tmp1 = delta_trans+...
        sample(a3*delta_trans+a4*(abs(delta_rot1)+abs(delta_rot2))); 
    tmp2 = delta_rot1+...
        sample(a1*abs(delta_rot1)+a2*delta_trans); 
    tmp3 = delta_rot2+...
        sample(a1*abs(delta_rot2)+a2*delta_trans);
    trajectory_data(1, n, t)=trajectory_data(1, n, t-1)+tmp1*cos(trajectory_data(3, n, t-1)+tmp2);
    trajectory_data(2, n, t)=trajectory_data(2, n, t-1)+tmp1*sin(trajectory_data(3, n, t-1)+tmp2);
    trajectory_data(3, n, t)=trajectory_data(3, n, t-1)+tmp2+tmp3;
end 
end
plot(odom(1,:),odom(2,:),'r','LineWidth',1.5); 
pause(3); 
hold on  
for m = 1:30 
  scatter(trajectory_data(1,5:500,m),trajectory_data(2,5:500,m),'.');   
  pause(.5);   
  hold on 
end 
