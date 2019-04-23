clear;clc;
close all;
SatellitePosition = [ 0 3 4;
                      4 0 5;
                      8 3 5;
                      4 8 4];
scatter3(SatellitePosition(:, 1),SatellitePosition(:, 2),SatellitePosition(:, 3));
hold on;
UserPosition=[4 4 0];
scatter3(UserPosition(1),UserPosition(2),UserPosition(3) ,"filled");hold on
for i = 1:length(SatellitePosition)
    plot3([SatellitePosition(i,1),UserPosition(1)],[SatellitePosition(i,2),UserPosition(2)],[SatellitePosition(i,3),UserPosition(3)])
end
R = [];
for i = 1:length(SatellitePosition)
    L = sqrt(sum((SatellitePosition(i,:)-UserPosition).^2));
    R = [R,L];
end
syms x y z

[x,y,z] = solve(R(1)^2 == sum(([x y z] - SatellitePosition(1,:)).^2), ...
                R(2)^2 == sum(([x y z] - SatellitePosition(2,:)).^2), ...                
                R(3)^2 == sum(([x y z] - SatellitePosition(3,:)).^2), ...
                R(4)^2 == sum(([x y z] - SatellitePosition(4,:)).^2) ...              
                ,x,y,z);
fprintf("result: %d, %d, %d",x,y,z);
for i = 1:length(SatellitePosition)
    plot3([SatellitePosition(i,1),x],[SatellitePosition(i,2),y],[SatellitePosition(i,3),z])
end