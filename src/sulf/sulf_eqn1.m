function [c,f,s] = sulf_eqn1(x,t,u,DuDx)

%%
% Units
% Distance: mm
% Time: Days

diff2 = 0; % Diffusion of sulfur reducers
death2 = 0.2; % Death rate of sulfur reducers
n2 = 1; % Hill coefficient for o2
k2 = 0.1; % rate constant for o2 inhibition on sulfur reducers
Nmax = 10; % number of total individuals allowed per pixel
mu2 = 20;     % growth rate for sulfur reducers

Sr = u(1);
N = Sr;
ch2o = 1;  % biomass
Kch2o = 0.1; % half max growth of sulfate reducers for biomass

IO2 = 10;
decayo2 = 1/10; % decay constant
o2 = IO2*exp(-decayo2*x);   % light 

c = [1; 1];
f = [diff2; diff3].*DuDx;
s = [ (k2/(o2^n2 + k2))*(Sr*mu2*ch2o / (Kch2o +ch2o))*(Nmax-N)/Nmax - death2*Sr];
%s = [0];
