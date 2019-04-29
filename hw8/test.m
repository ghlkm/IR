
function test()
clear;clc;
hold on

circleplot(530,200,20,pi)

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