function u = initial1(x)
%INITIAL1: MATLAB function M-file that specifies the initial condition
%for a PDE in time and one space dimension.

C = 100;
Sr = 100;
Cs = 100;
if x==0 
    O2 = 200;
else
    O2 = 0;
end
H2S = 0;
CH2O = 50;

u = [C; Sr; O2; H2S; CH2O; Cs];