
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k1 = 1;  % rate constant for H2S
n1 = 1;  % hill constant for H2S
u1 = 1;  % growth rate for H2S
Nmax = 10000; % maximum number of individuals
C0 = 1; % number of Cyanobacteria at first time point
S0 = 1; % number of Sulfer Reducers at first time point

% symmetry (cartesian aka rectangular coords)
m = 0;
pdefun;  % partial differiential equations
sol = pdepe(m,pdefun,icfun,bcfun,xmesh,tspan);