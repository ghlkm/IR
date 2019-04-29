function p2()
function circleplot(xc, yc, r, theta) 
t = 0 : .01 : 2*pi; 
locx = r * cos(t) + xc; 
locy = r * sin(t) + yc; 
plot(locx, locy,'r','LineWidth',2)
t2 = 0 : .01 : r; 
locx = t2 * cos(theta) + xc; 
locy = t2 * sin(theta) + yc; 
plot(locx, locy,'r','LineWidth',2)
end
% figure(1)
clc;clear;
close all;
hold on

circleplot(-50, 50, 3, -pi/4);
circleplot(0, 50, 3, -pi/2);
circleplot(50, 50, 3, -pi/4*3);
circleplot(50, -50, 3, pi/4*3);
circleplot(0, -50, 3, pi/2);
circleplot(-50, -50, 3, pi/4);


circleplot(0, 0, 5, 0);


num=10000;
theta = rand(1, num)*pi*2;
nu=cos(theta);
nv=sin(theta);
nx=rand(1, num)*100-50;
ny=rand(1, num)*100-50;
quiver(nx,ny,nu,nv, 0.4);


% 画resample 之后的结果
%{
1. resample
2. 画
%}  

    function f = gauss_distribution(x, mu, s)
        p1 = -.5 * ((x - mu)/s) .^ 2;
        p2 = (s * sqrt(2*pi));
        f = exp(p1) ./ p2;
    end

    function locpdf=ldm(zx, zy ,ztt, x,y, d, alpha, ed,ea)
        %landmark_detection_model
        % x, y 标记物
        dist = ((zx-x).^2+(zy-y).^2).^.5;
        dalpha = atan2(zy-y, zx-x)-ztt; %delta_alpah
        pdet=gauss_distribution(dist - d, 0, ed).*...
             gauss_distribution(dalpha-alpha,0, ea);
        tmp=sum(pdet);
        locpdf=pdet/tmp;
        %{
        for i=1:length(dist)
            disp(dist(i))
            disp(pdet(i))
            disp("3#3#")
        end
        %}
    end
    pdf=ones(1, length(nx));
    ea=pi/2;
    ed=10;
    pdf=pdf.*ldm(nx, ny, theta, -50,50,   50*(2^.5), 7*pi/4, ed, ea );
    pdf=pdf.*ldm(nx, ny, theta, 0,  50,   50 ,       6*pi/4, ed, ea );
    pdf=pdf.*ldm(nx, ny, theta, 50, 50,   50*(2^.5), 5*pi/4, ed, ea );
    pdf=pdf.*ldm(nx, ny, theta, 50, -50,  50*(2^.5), 3*pi/4, ed, ea );
    pdf=pdf.*ldm(nx, ny, theta, 0, -50,   50,        2*pi/4, ed, ea );
    pdf=pdf.*ldm(nx, ny, theta, -50, -50, 50*(2^.5), 1*pi/4, ed, ea );
    gtmp=sum(pdf);
    pdf=pdf/gtmp;
    cdf(1)=pdf(1);
    for i=2:length(pdf)
        cdf(i)=cdf(i-1)+pdf(i);
    end
    disp(cdf(length(cdf)))
    sy=[];sx=[];st=[];
    for i=1:100
        r=rand();
        j=1;
        while(r>cdf(j))
           j=j+1;
        end
        sx=[sx, nx(int32(j))];
        sy=[sy, ny(int32(j))];
        st=[st, theta(int32(j))];
    end
    nu=cos(st);
    nv=sin(st);
    figure(2)
    hold on
    circleplot(-50, 50, 3, -pi/4);
    circleplot(0, 50, 3, -pi/2);    
    circleplot(50, 50, 3, -pi/4*3);
    circleplot(50, -50, 3, pi/4*3);
    circleplot(0, -50, 3, pi/2);
    circleplot(-50, -50, 3, pi/4);
    circleplot(0, 0, 5, 0);
    quiver(sx,sy,nu,nv, 0.4);
    axis([-60 60 -60 60])
end