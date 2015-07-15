function [pl,ql,pr,qr] = bc1(xl,ul,xr,ur,t)
%BC1: MATLAB function M-file that specifies boundary conditions
%for a PDE in time and one space dimension.

pl = [0;         % no restriction on cyanobacteria concentration
      0;         % no restriction on sulfate reducer concentration
      ul(3)-0.2; % oxygen is 0.2 on the top
      ul(4);     % hydrogen sulfide concentration is not restricted on flux?      
      0;         % no restriction on biomass concentration top
      ]; 
ql = [1;   % no flux from cyanobacteria from top
      1;   % no flux from sulfate reducers from top
      0;   % no restriction on oxygen flux from top
      0    % no restriction on hydrogen sulfide flux from top
      1;   % no flux from biomass concentration from top
      ];
pr = [0;      % no restriction on cyanobacteria concentration
      0;      % no restriction on sulfate reducer concentration
      ur(3);  % oxygen concentration is not restricted on flux   
      ur(4)   % hydrogen sulfide concentration is not restriction on flux
      0;      % no restriction on biomass concentration bottom
      ]; 
qr = [1;   % no flux from cyanobacteria from bottom
      1;   % no flux from sulfate reducers from bottom
      0;   % oxygen concentration is not restricted on flux from bottom
      0    % no restriction on hydrogen sulfide flux from bottom
      1;   % no flux from biomass concentration from from
      ];