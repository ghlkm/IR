% resample the set of particles.
% A particle has a probability proportional to its weight to get
% selected. A good option for such a resampling method is the so-called low
% variance sampling
function newParticles = resample(particles)
% TODO: resample particles by their important factors
    step = 1/length(particles);
    u = rand*step;
    c=particles(1).weight;
    i=1;
    for j=1:length(particles)
        while u>c
            newParticles(i)=particles(i);
            i=i+1;
            c=c+particles(i).weight;
        end
        newParticles(i)=particles(i);
        newParticles(i).weight=step;
        u=u+step;
    end
end
