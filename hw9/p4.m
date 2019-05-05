function p4()
close all
clear
[A, B, C, D]=deal([-.5, .5], [-1, -1], [1.5, -1], [1.3, 1.3]);
function d=dist(p1, p2) 
    d=sum((p1-p2).^2)^.5; 
end

Q=[0, 0];
r=[dist(Q,A), dist(Q,B), dist(Q, C), dist(Q,D)];
theta=[ atan2(A(2)- Q(2), A(1)-Q(1)),...
        atan2(B(2)- Q(2), B(1)-Q(1))...
        atan2(C(2)- Q(2), C(1)-Q(1))...
        atan2(D(2)- Q(2), D(1)-Q(1))];

function f = gauss_distribution(x, mu, s)
    p1 = -.5 * ((x - mu)/s) .^ 2;
    p2 = (s * sqrt(2*pi));
    f = exp(p1) ./ p2;
end
e=[.3, .3, .3, .3];
ea=[pi/6, pi/6, pi/6, pi/6];

function p=point_guassian(xs, ys, r, e, ea, theta)
         p=gauss_distribution(((xs-Q(1)).^2+(ys-Q(2)).^2).^.5-r, 0,e);
         p=p.*gauss_distribution(atan2(ys-Q(2), xs-Q(2))-theta ,0,ea);
end
for i=1:4
   figure(i);
   f=@(x, y) point_guassian(x, y, r(i), e(i), ea(i), theta(i));
   fsurf(f,[-2 2 -2 2]);
end

end