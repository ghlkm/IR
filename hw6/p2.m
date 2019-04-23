
close all
axis equal
hold off
SIZE=100;
sigma1=9;
sigma2=9;
sigma3=9;
pd=zeros(SIZE);
dist=zeros(SIZE);
N=@(x, u, g) 1/(2*pi*g)^.5 *exp(-.5*(x-u)^2/g/g);
p1 = [30 70];
p_2 = [45 30];
p3 = [55 40];
for i=1:1:SIZE
    for j=1:1:SIZE
        p=[i j];
        tmp1=pdist2(p, p1)-7;
        tmp2=pdist2(p, p_2)-3;
        tmp3=pdist2(p, p3)-3;
        if tmp1<0
            tmp1=0;
        end
        if  tmp2<0
            tmp2=0;
        end 
        if tmp3 <0
            tmp3=0;
        end
        dist(i,j)=min([tmp1, tmp2, tmp3]);
        pd(i,j)=max([N(tmp1, 0, sigma1),...
                     N(tmp2, 0, sigma2),...
                     N(tmp3, 0, sigma3)]);
    end
end
[z_hit, z_random, z_max]=deal(.7, .2, .1);

q=z_hit*pd+z_random/SIZE;
heatmap(q, 'Colormap', gray)

%single_measure
max_len=99;
ys=1;
pause(5)
close all 
hold on

pdk=pd(50, ys:SIZE);
pdk(max_len:length(pdk))=...
    z_hit * pdk(max_len:length(pdk)) + z_max * 1/(SIZE-max_len);
plot(1:length(pdk) ,pdk)
%{
plot(1:max_len+1, pd(50, ys:ys+max_len));
plot([max_len+1 max_len+2], [pd(50, ys+max_len) 1/(SIZE-ys-max_len+1)])
plot(max_len+1:SIZE-ys-max_len+1, ones(SIZE-ys-2*max_len+1, 1)/(SIZE-ys-max_len+1))
%}

        
            
  