%{
Gaussian
%}
close all
for i=1:1:10e6
    x(i) = sum(rand(12,1))/2; % maximum abs is 6
end
h = histogram(x,'Normalization','pdf');