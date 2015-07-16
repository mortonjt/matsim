function [c,f,s] = eqn1(x,t,u,DuDx)

%%
% Units
% Distance: mm
% Time: hours

Nmax = 10e3;  % number of total individuals allowed per pixel
              % includes cyanobacteria and sulfur reducers

C = u(1);     % Concentration of cyanobacteria  
Sr = u(2);    % Concentration of sulfate reducers
Cs = u(6);    % colorless sulfur bacteria
N = C+Sr+Cs;     % Total concentration of individuals
              
%% Cyanobacteria
mu1=log(2)/6; % max growth rate for cyanos
diff1 = 1;    % Diffusion of cyanos mm/hr
death1=mu1/10;% Death rate of cyanos (number / hour)
n1 = 1;       % Hill coefficient for h2s ??? (Alfred?)
k1 = 1;       % rate constant for h2s inhibition on cyano ??? (Alfred?)

Khv = 1;      % Half max for light ???
Ihv = 10;     % Intensity of light on the ground ???
decayhv = 1/2;% decay constant 
hv = Ihv*exp(-decayhv*x);   % light 


%% Sulfate Reducers
diff2 = 1;    % Diffusion of sulfate reducers mm/hr
mu2 = log(2)/6; % max growth rate for sulfate reducers (number / hour)
death2=mu2/10;% Death rate of sulfate reducers
n2 = 1;       % Hill coefficient for o2 ??? (Alfred?)
k2 = 1;       % rate constant for o2 inhibition on sulfate reducers ??? (Alfred?)
Kch2o = 1;    % half max growth for sulfate reducers with biomass ??? (Alfred?)

%% Oxygen
diff3 = 7;    % Diffusion for oxygen (mm/hr)
k3 = 1/2;       % Rate constant for oxygen production from cyanobacteria ??? (Alfred?) 
              %     (mol vs M?)
k4 = .1;       % Reactivity constant for oxygen combining with H2S ??? (Alfred?)
              %     (mol vs M?)
O2 = u(3);    % Concentration of oxygen

%% Hydrogen Sulfide
diff4 = 7;    % Diffusion for hydrogen sulfide
k5 = 1/10;       % Rate constant for hydrogen sulfide from sulfate reducers (uM)
H2S = u(4);   % Concentration for hydrogen sulfide

%% Biomass
diff5 = 5;    % Diffusion for biomass
k6 = 4;       % Rate constant for biomass conversion from cyano death ??? (Alfred?)
k7 = 4;       % Rate constant for biomass conversion sulfate reducer death ??? (Alfred?)
k8 = 4;       % Rate constant for sulfate reducers consuming biomass ??? (Alfred?)
k10 = 4;      % Rate constant for colorless sulfur consuming biomass ??? (Alfred?)
k11 = 4;      % Rate constant for biomass conversion colorless death ??? (Alfred?)

CH2O = u(5);  % Biomass

%% Colorless Sulfur Bacteria
diff6 = 3;   % Diffusion of colorless mm/hr
mu3 = log(2); % max growth rate for colorless (number / hour)
death3=mu3/100;% Death rate of colorless
k9 = 1000;    % Rate constant for hydrogen sulfide inhibition on colorless
n3 = 4;       % Hill coefficient for hydrogen sulfide inhibition on colorless
k12 = 0.2;    % Hydrogen sulfide loss due to growth of colorless
Kh2s = 1/100; % Rate constant for growth due to hydrogen sulfide 
Ko2 = 1/100;  % Rate constant for growth due to oxygen
k13 = .8;    % Rate constant for oxygen consumption due to colorless sulfur
n4 = 4;       % Hill coefficient for oxygen inhibition on colorless
k14 = 1000;   % Inhibition due to oxygen
%% Growth terms
cyano_growth = (k1/(H2S^n1 + k1))*(C*mu1*hv / (Khv +hv))*(Nmax-N)/Nmax;
sulfate_growth = (k2/(O2^n2 + k2))*(Sr*mu2*CH2O / (Kch2o +CH2O))*(Nmax-N)/Nmax;
colorless_growth = (k9 / (H2S^n3 + k9)) * (k14 / (O2^n4 + k14)) ...
                   * (Nmax-N)/Nmax ...
                   * Cs*mu3*(H2S / (Kh2s + H2S))*(O2 / (Ko2 + O2));
%colorless_growth = Cs*mu3*(H2S / (Kh2s + H2S))*(O2 / (Ko2 + O2)) * (Nmax-N)/Nmax;

c = [1; 1; 1; 1; 1; 1];
f = [diff1; 
     diff2;
     diff3;
     diff4;
     diff5;
     diff6].*DuDx;
 

s = [% cyanos
     cyano_growth - death1*C;         
     % sulfate reducers
     sulfate_growth - death2*Sr;
     % Oxygen
     k3 * cyano_growth ...
     - k13 * colorless_growth ...
     - k4*H2S*O2;
     % Hydrogen sulfide
     k5 * sulfate_growth ...
     - k12*colorless_growth ...
     - k4*H2S*O2;
     % Biomass
     -k8*sulfate_growth + ...
     -k10*colorless_growth + ...
     k6*death1*C + k7*death2*Sr + k11*death3*Cs;
     % Colorless Sulfur bacteria
     colorless_growth - death3*Cs
     ];

