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
sqrt(b)=30
lambda = .0015

1. set alpha1, alpha2, alpha3, alpha4
2. integration and fix P_hit
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
function p4
close all
samples_num=50;
z_max=500;
z_small=10;
z_exp=250;
b=900; %  \sigma ^2
lambda = .0015;

% sum of ai(alphai) should be 1
% or you can normailze the sum of them to 1
% a_hit, a_upexp, a_max, a_rand
[a1, a2, a3, a4] =deal(0.5, 0.3, 0.18, .02); 
[c1, c2, c3, c4] =deal(1,2 , 3, 4); % this could be arbitary 
P_hit   =@(z) c1 / ((2 * pi * b)^.5) * exp(-.5*((z - z_exp)^2)/b);
P_unexp =@(z) c2 * (sign(z_exp-z)+1)/2 * lambda * exp(-lambda * z);
P_rand  =@(z) c3 / z_max;
P_max   =@(z) c4 * (sign(z- (z_max-z_small)) +1)/2;

%{ integration and normalize %}
integration1=0;
integration2=0;
integration3=0;
integration4=0;
for i=1:1:z_max
	integration1=integration1+P_hit(i);
    integration2=integration2+P_unexp(i);
    integration3=integration3+P_rand(i);
    integration4=integration4+P_max(i);
end
c1=c1/integration1;
c2=c2/integration2;
c3=c3/integration3;
c4=c4/integration4;

%{ redefine those funtion based on the new ci %}
P_hit   =@(z) c1 / ((2 * pi * b)^.5) * exp(-.5*((z - z_exp)^2)/b);
P_unexp =@(z) c2 * (sign(z_exp-z)+1)/2 * lambda * exp(-lambda * z);
P_rand  =@(z) c3 / z_max;
P_max   =@(z) c4 * (sign(z- (z_max-z_small)) +1)/2;

% pd = probability density 
pd =@(z) (a1*P_hit(z)+a2*P_unexp(z)+a3*P_rand(z)+a4*P_max(z));
% we only need the same shape just divide it with f_max instead of
%    1/sample_nums
f_max=0;
for i=0:0.1:z_max
    p=pd(i);
    if p>f_max
        f_max=p;
    end
end
x=zeros(samples_num, 1);
for i=1:1:samples_num
    % rejection sampling
    x(i)=z_max*rand();
    while rand()>pd(x(i))/f_max
       x(i)=z_max*rand(); 
    end
end
%{
Ax<=b
%}
A=[1 1 1 1;-1 -1 -1 -1];
b=[1.1 -.9];
    function q=ea(a)
        q=1;
        for ii=1:length(x)
            q=(a(1)*P_hit(x(ii))+a(2)*P_unexp(x(ii))+a(3)*P_rand(x(ii))+a(4)*P_max(x(ii)))/f_max*q;
        end
        q=-q*1e20;
    end
%{
options = optimoptions('fmincon', 'Algorithm','sqp','OptimalityTolerance', 1e-100);
problem.options = options;
problem.solver = 'fmincon';
problem.objective = @ea;
problem.x0 = [.72 .18 .05 .05];
%}
% [a1, a2, a3, a4] =deal(0.5, 0.3, 0.18, .02); 
solution=fmincon(@ea, [.72 .18 .05 .05], A, b, [],[],  [0 0 0 0], [1 1 1 1]);
%solution=fmincon(problem);
disp(solution);
end
