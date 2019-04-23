function p3()
close all
clear
hold on
sample=100;
a = [0 0];
b = [10 0];
c = [10 30];
d = [-3 15];
options = optimoptions('fsolve', 'Algorithm', 'levenberg-marquardt');
pd = zeros(sample, 2);
da = (sum((a-d).^2))^.5;
db = (sum((b-d).^2))^.5;
dc = (sum((c-d).^2))^.5;
function dr = cal(p)
    pa =(sum((a-p).^2))^.5;
    pb = pdist2(b, p);
    pc = pdist2(c, p);
    dr(1) = abs(pa - nda);
    dr(2) = abs(pb - ndb);
    dr(3) = abs(pc - ndc);
end
for i = 1:sample
    nda = da + .06*randn();
    ndb = db + .07*randn();
    ndc = dc + .08*randn();
    pd(i, :) = fsolve(@cal, [0 0], options);
end
plot([a(1) b(1) c(1)], [a(2) b(2) c(2)], 'o')
scatter(pd(:,1), pd(:,2), 'filled');
end