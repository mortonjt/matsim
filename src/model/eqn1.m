function [c,f,s] = eqn1(x,t,u,DuDx)

%%
% Units
% Distance: mm
% Time: Days

%% Cyanobacteria
diff1 = 2;    % Diffusion of cyanos
death1 = 0.2; % Death rate of cyanos
n1 = 1;       % Hill coefficient for h2s
k1 = 1;       % rate constant for h2s inhibition on cyano
Nmax = 10;    % number of total individuals allowed per pixel

mu1 = 20;     % growth rate for cyanos
Khv = 1;      % Half max for light 
Ihv = 10;     % Intensity on the ground
decayhv = 1/2;% decay constant
hv = Ihv*exp(-decayhv*x);   % light 

C = u(1);     % Concentration of cyanobacteria

%% Sulfate Reducers
diff2 = 2;    % Diffusion of sulfate reducers
death2 = 0.2; % Death rate of sulfate reducers
n2 = 1;       % Hill coefficient for h2s
k2 = 1;       % rate constant for h2s inhibition on sulfate reducers
Nmax = 10;    % number of total individuals allowed per pixel
mu2 = 20;     % growth rate for sulfate reducers
Kch2o = 1;    % half max growth for sulfate reducers with biomass

Sr = u(2);    % Concentration of sulfate reducers
N = C+Sr;     % Total concentration of individuals

%% Oxygen
diff3 = 0;    % Diffusion for oxygen
k3 = 1;       % Rate constant for oxygen production from cyanobacteria
k4 = 1;       % Reactivity constant for oxygen combining with H2S
O2 = u(3);    % Concentration of oxygen

%% Hydrogen Sulfide
diff4 = 0;    % Diffusion for hydrogen sulfide
k5 = 1;       % Rate constant for hydrogen sulfide from sulfate reducers
H2S = u(4);   % Concentration for hydrogen sulfide

%% Biomass
diff5 = 0;    % Diffusion for biomass
k6 = 0;       % Rate constant for biomass conversion from cyano death
k7 = 0;       % Rate constant for biomass conversion sulfate reducer death
k8 = 0;       % Rate constant for sulfate reducers consuming biomass

CH2O = u(5);

c = [1; 1; 1; 1; 1];
f = [diff1; 
     diff2;
     diff3;
     diff4;
     diff5].*DuDx;
s = [(k1/(H2S^n1 + k1))*(C*mu1*hv / (Khv +hv))*(Nmax-N)/Nmax - death1*C;
     (k2/(O2^n2 + k2))*(Sr*mu2*CH2O / (Kch2o +CH2O))*(Nmax-N)/Nmax - death2*Sr;
     k3*(k1/(H2S^n1 + k1))*(C*mu1*hv / (Khv +hv))*(Nmax-N)/Nmax - k4*H2S*O2;
     k5*(k2/(O2^n2 + k2))*(Sr*mu2*CH2O / (Kch2o +CH2O))*(Nmax-N)/Nmax - k4*H2S*O2;
     -k8*(k2/(O2^n2 + k2))*(Sr*mu2*CH2O / (Kch2o +CH2O))*(Nmax-N)/Nmax + ...
     k6*death1*C + k7*death2*Sr];

%s = [0];
