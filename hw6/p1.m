%{
@author Keming Li
@sid    11612126
@mail   11612126@mail.sustech.edu.cn

P_hit   = c1 * 1 / ((2 * pi * b)^.5) * e ^(-.5*((z - z_exp)^2)/b)
P_unexp = z < z_exp ? c2 * lambda * exp(-lambda * z) : 0
P_rand  = c3 * 1 / z_max
P_max   = c4 / z_small

1e4 samples
z_max=500
b=50
lambda = .005

1. set alpha1, alpha2, alpha3, alpha4
2. integration to 1, get K
3. get sample function
4. reject sampling

I am lazy to calculate the integration
just let the work done by the computer

originally I normalize the probability density function but I find:

1. if the range is large, then the probability density will be very small
this could lead to the result such that not easy to 
    generate proper random number with rejection sampling method
2. but if we base on the maximum f
   we can reject no that much of the samples and also get the same shape!!

%}

close all
samples_num=1e4;
z_max=500;
z_small=10;
z_exp=250;
b=2500; % \rou ^2
lambda = .0015;
[c1, c2, c3, c4] =deal(10, 10, 4, .1); % c1/alpha1 = c2/alpha2 = c3/alpha3 = c4/alpha4 = s
P_hit   =@(z) c1 / ((2 * pi * b)^.5) * exp(-.5*((z - z_exp)^2)/b);
P_unexp =@(z) c2 * (sign(z_exp-z)+1)/2 * lambda * exp(-lambda * z);
P_rand  =@(z) c3 / z_max;
P_max   =@(z) c4 * (sign(z- (z_max-z_small)) +1)/2;
%{ integration %}
%K=0;
f_max=0;
pd =@(z) (P_hit(z)+P_unexp(z)+P_rand(z)+P_max(z));
for i=0:0.1:z_max
    p=pd(i);
    if p>f_max
        f_max=p;
    end
    %K=K+p;
end

x=zeros(samples_num, 1);
s=0;
for i=1:1:500
    x(i)=pd(i);
    s=s+x(i);
end
plot(1:1:500, x(1:500)./s)
pause(10);

% pd = probability density * K
% we only need the same shape just divide it with f_max instead of K
x=zeros(samples_num, 1);
for i=1:1:samples_num
    %rejection sampling
    x(i)=int16(z_max*rand());
    while rand()>pd(x(i))/f_max
       x(i)=int16(z_max*rand()); 
    end
end
plot(1:1:samples_num, x, '+', 'MarkerSize',2)
pause(10);

h = histogram(x,'Normalization','pdf', 'NumBins',50);
