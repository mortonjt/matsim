function [c,f,s] = eqn1(x,t,u,DuDx)

diff1 = 1; % Diffusion of cyanos
death1 = 0.02; % Death rate of cyanos
n1 = 1; % Hill coefficient for h2s
k1 = 1; % rate constant for h2s inhibition on cyano
Nmax = 10; % number of total individuals allowed per pixel

mu1 = 20;     % growth rate for cyanos
Khv = 1;      % Half max for light 
Ihv = 10;     % Intensity on the ground
decayhv = 1/2; % decay constant
hv = Ihv*exp(-decayhv*x);   % light 

C = u(1);
h2s = 0;
N = C;

c = [1];
f = [diff1].*DuDx;
s = [ (k1/(h2s^n1 + k1))*(C*mu1*hv / (Khv +hv))*(Nmax-N)/Nmax - death1*C];
%s = [0];
