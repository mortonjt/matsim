%PDE1: MATLAB script M-file that solves and plots
%solutions to the PDE stored in eqn1.m
m = 0;
%NOTE: m=0 specifies no symmetry in the problem. Taking
%m=1 specifies cylindrical symmetry, while m=2 specifies
%spherical symmetry.
%
%Define the solution mesh
x = linspace(0,100,100);
t = linspace(0,4,20);
%Solve the PDE
u = pdepe(m,@eqn1,@initial1,@bc1,x,t);

%Plot solution for cyanobacteria
figure
surf(x,t,u(:,:,1));
title('Surface plot of cyanobacteria.');
xlabel('Distance x')
ylabel('Time t')

figure
%Plot solution for sulfate reducers
surf(x,t,u(:,:,2));
title('Surface plot of sulfate reducers.');
xlabel('Distance x')
ylabel('Time t')

%Plot solution for oxygen
figure
surf(x,t,u(:,:,3));
title('Surface plot of oxygen.');
xlabel('Distance x')
ylabel('Time t')

%Plot solution for hydrogen sulfide
figure
surf(x,t,u(:,:,4));
title('Surface plot of hydrogen sulfide.');
xlabel('Distance x')
ylabel('Time t')

%Plot solution for biomass
figure
surf(x,t,u(:,:,5));
title('Surface plot of biomass.');
xlabel('Distance x')
ylabel('Time t')