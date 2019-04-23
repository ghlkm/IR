function p3_v2()
close all
clear
hold on
sample=100;
a = [0 0];
b = [10 0];
c = [10 30];
d = [-3 15];
% trueth value
da = (sum((a-d).^2))^.5;
db = (sum((b-d).^2))^.5;
dc = (sum((c-d).^2))^.5;
where=zeros(sample,2);
for i = 1:sample
    nda = da + .06*randn();
    ndb = db + .07*randn();
    ndc = dc + .08*randn();
    where(i, :) = fsolve(@F, [-1 1]);    
end
plot([a(1) b(1) c(1)], [a(2) b(2) c(2)], 'o')
plot(where(:, 1),where(:,2), 'o','MarkerSize', 5)
 function y=F(x)
    y(1)=(sum((a-x).^2))^.5-nda;
    y(2)=(sum((b-x).^2))^.5-ndb;
    y(3)=(sum((c-x).^2))^.5-ndc;
end
end
