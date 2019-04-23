close all
for i=1:1:10e6
    tmp=0;
    x(i)=1;
    while(x(i)>tmp^2)
        tmp=rand()-0.3;
        x(i)=rand()*0.49;
    end
    x(i)=tmp;
end
h = histogram(x,'Normalization','pdf');