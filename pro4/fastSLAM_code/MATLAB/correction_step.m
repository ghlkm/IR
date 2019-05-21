function particles = correction_step(particles, z, noise)

% Weight the particles according to the current map of the particle
% and the landmark observations z.
% z: struct array containing the landmark observations.
% Each observation z(j) has an id z(j).id, a range z(j).range, and a bearing z(j).bearing
% The vector observedLandmarks indicates which landmarks have been observed
% at some point by the robot.

% Number of particles
Num_particles = length(particles);

% Number of measurements in this time step
m = size(z, 2);

% TODO: Construct the sensor noise matrix Q_t (2 x 2)
Q_t = noise;

% process each particle
for i = 1:Num_particles
  robot = particles(i).pose;    % vector of [x, y, theta]'
  x=robot(1);
  y=robot(2);
  theta=robot(3);
  % process each measurement
  for j = 1:m
    % Get the id of the landmark corresponding to the j-th observation
    % particles(i).landmarks(l) is the EKF for this landmark
    l = z(j).id;

    % The (2x2) EKF of the landmark is given by
    % its mean particles(i).landmarks(l).mu
    % and by its covariance particles(i).landmarks(l).sigma

    % If the landmark is observed for the first time:
    if (particles(i).landmarks(l).observed == false)
      
      % TODO: Initialize its position based on the measurement and the current robot pose:
	  particles(i).landmarks(l).mu(1) = x+z(j).range*cos(theta+z(j).bearing);
	  particles(i).landmarks(l).mu(2) = y+z(j).range*sin(theta+z(j).bearing);

      % get the Jacobian with respect to the landmark position
      [h, H] = measurement_model(particles(i), z(j));

      % TODO: initialize the covariance for this landmark
	  H_inv = inv(H);
      particles(i).landmarks(l).sigma = H_inv * Q_t * H_inv';

      % Indicate that this landmark has been observed
      particles(i).landmarks(l).observed = true;

    else

      % get the expected measurement
      [expectedZ, H] = measurement_model(particles(i), z(j));
        
      % TODO: compute the measurement covariance
      Q = H * particles(i).landmarks(l).sigma *H' + Q_t;
	  
      % TODO: calculate the Kalman gain
      K = particles(i).landmarks(l).sigma * H' * inv(Q);

      % TODO: compute the error between the z and expectedZ (remember to normalize the angle using the function normalize_angle())
      delta_z= [z(j).range - expectedZ(1), normalize_angle(z(j).bearing-expectedZ(2))];

      % TODO: update the mean and covariance of the EKF for this landmark
      particles(i).landmarks(l).mu = particles(i).landmarks(l).mu + (K*delta_z')'; 
	  particles(i).landmarks(l).sigma =([1 0; 0 1;]-K*H) * particles(i).landmarks(l).sigma;
      % TODO: compute the likelihood of this observation, multiply with the former weight
      %       to account for observing several features in one time step
      fact=1/sqrt(det(2*pi*Q_t));
      expo=-0.5*delta_z*inv(Q_t)*delta_z';
      particles(i).weight=particles(i).weight * fact .*exp(expo);

    end

  end % measurement loop
end % particle loop

normalizer=sum([particles.weight]);
len = length(particles);
for k = 1:len
  particles(k).weight=particles(k).weight./normalizer;
end
end
