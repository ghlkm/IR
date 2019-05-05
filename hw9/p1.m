function p1()
close all
clear
[A, B, C, D]=deal([-1, 1], [-1, -1], [1, -1], [1, 1]);
function d=dist(p1, p2) 
    d=sum((p1-p2).^2)^.5; 
end
function S=area(len1, len2, len3)
    p=(len1+len2+len3)/2;
    S=(p*(p-len1)*(p-len2)*(p-len3))^.5;
end

Q=[.5, .5];
[r1, r2, r3, r4]=deal(dist(Q,A), dist(Q,B), dist(Q, C), dist(Q,D));

function e=F(a)
    e=area(r1, r2, a)+area(r2, r3, a)+area(r3, r4, a)+area(r4, r1, a)-a*a;   
end


range1=max([abs(r1-r2), abs(r2-r3), abs(r3-r4),abs(r4-r1)]);%c>a+b
range2=min([abs(r1+r2), abs(r2+r3), abs(r3+r4),abs(r4+r1)]);%c<a+b
a0=rand()*(range2-range1)+range1;
disp(a0);
a=fsolve(@F, a0);
disp(a);

function f = gauss_distribution(x, mu, s)
    p1 = -.5 * ((x - mu)/s) .^ 2;
    p2 = (s * sqrt(2*pi));
    f = exp(p1) ./ p2;
end
[e1,e2, e3, e4]=deal(.3, .3, .3, .3);

    function p=mulp(points)
        p=  gauss_distribution(dist(points(1, :), Q)-r1, 0, e1);
        p=p*gauss_distribution(dist(points(2, :), Q)-r2, 0, e2);
        p=p*gauss_distribution(dist(points(3, :), Q)-r3, 0, e3);
        p=p*gauss_distribution(dist(points(4, :), Q)-r4, 0, e4);
    end

function p=p1_guassian(xs, ys)
       p=zeros(length(xs), 1);
       for i=1:length(xs)
        x=xs(i);y=ys(i);
        points(1, 1:2)=[x, y];
        points(2, 1:2)=[x, y-a];
        points(3, 1:2)=[x+a, y-a];
        points(4, 1:2)=[x+a, y];
        p(i)=mulp(points);
       end
end
function p=p2_guassian(xs, ys)
       p=zeros(length(xs), 1);
       for i=1:length(xs)
        x=xs(i);y=ys(i);
        points(1, 1:2)=[x, y+a];
        points(2, 1:2)=[x, y];
        points(3, 1:2)=[x+a, y];
        points(4, 1:2)=[x+a, y+a];
        p(i)=mulp(points);
      end
end
function p=p3_guassian(xs, ys)
       p=zeros(length(xs), 1);
       for i=1:length(xs)
        x=xs(i);y=ys(i);
        points(1, 1:2)=[x-a, y+a];
        points(2, 1:2)=[x-a, y];
        points(3, 1:2)=[x, y];
        points(4, 1:2)=[x, y+a];
        p(i)=mulp(points);
       end
end
function p=p4_guassian(xs, ys)
       p=zeros(length(xs), 1);
       for i=1:length(xs)
        x=xs(i);y=ys(i);
        points(1, 1:2)=[x-a, y];
        points(2, 1:2)=[x-a, y-a];
        points(3, 1:2)=[x, y-a];
        points(4, 1:2)=[x, y];
        p(i)=mulp(points);
       end
end
figure(1);
f1=  @(x,y) p1_guassian(x, y);    
fsurf(f1,[-2 2 -2 2]);
figure(2);
f2=  @(x,y) p2_guassian(x, y);    
fsurf(f2,[-2 2 -2 2]);
figure(3);
f3=  @(x,y) p3_guassian(x, y);    
fsurf(f3,[-2 2 -2 2]);
figure(4);
f4=  @(x,y) p4_guassian(x, y);    
fsurf(f4,[-2 2 -2 2]);
end