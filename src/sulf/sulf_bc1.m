function [pl,ql,pr,qr] = bc1(xl,ul,xr,ur,t)
%BC1: MATLAB function M-file that specifies boundary conditions
%for a PDE in time and one space dimension.

% No flux BCs on both sides
pl = [0]; 
ql = [1];
pr = [0]; 
qr = [1];