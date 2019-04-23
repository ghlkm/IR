%{
triangle
%}
close all
for i=1:1:10e6
    x(i) = (rand()+rand())*tmp;
end
h = histogram(x,'Normalization','pdf');