%{
abs:
    三角取样:
    r=rand+rand
    中点:
    m=(a+b)/2  
    轴对称变换:
    if r>m:    
        x=b+m-r
    else r<=m
        x=a+m-r
    化简:
    2m-r+sign(r-m)*(b-a)/2
    参数设置:
    m=1, b=2, a=0
    代入:
    2-r+sign(r-1)
%}
close all
for i=1:1:10e6
    tmp=rand()+rand();
    x(i) = 2-tmp+sign(tmp-1);
end
h = histogram(x,'Normalization','pdf');