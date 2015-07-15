function u = initial1(x)
%INITIAL1: MATLAB function M-file that specifies the initial condition
%for a PDE in time and one space dimension.

C = 1;
Sr = 1;
if x==0 
    O2 = 0.2;
else
    O2 = 0;
end
H2S = 0;
CH2O = 1;

u = [C; Sr; O2; H2S; CH2O];