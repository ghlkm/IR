%{
abs:
    ����ȡ��:
    r=rand+rand
    �е�:
    m=(a+b)/2  
    ��ԳƱ任:
    if r>m:    
        x=b+m-r
    else r<=m
        x=a+m-r
    ����:
    2m-r+sign(r-m)*(b-a)/2
    ��������:
    m=1, b=2, a=0
    ����:
    2-r+sign(r-1)
%}
close all
for i=1:1:10e6
    tmp=rand()+rand();
    x(i) = 2-tmp+sign(tmp-1);
end
h = histogram(x,'Normalization','pdf');