close all
clear all
%% Global Variables
% define global variables to share with function file
global gamma omega epsilon GAMMA OMEGA
% initialise global variables
omega = 1;
gamma = 0.1;
epsilon = 0.25;

%% Input Variables
% Two inputs from problem sheet: same capital omega, different capital
% gamma. SI units assumed for graph labels
OMEGA = 2;
%GAMMA = 0.5;
GAMMA = 1.5;

%% Solving the ODE
% Time divisions, T is the period of the driving force
T = 2*pi/OMEGA;
deltat = T/100;
% Range over which the ODE is solved
t_solve_range = 0:deltat:4000;
[t, x] = ode45(@oscil_eqn, t_solve_range, [1 0]);

%% Plotting
% find indices for delineating plot ranges. direct matching doesn't work,
% don't know why. elems is vector of indices of all elements between 20T & 60T
% inclusive (always inclusive? check- Probably floating point error)
start_find = 20*T;
end_find = 60*T;
elems = find(t_solve_range>=start_find & t_solve_range<=end_find);
% Plot ranges
t_plot_range = t_solve_range(elems);
% ode45 produced two column matrix with first column y solutions, slice y
% solutions
xs = x(:, 1);
x_plot_range = xs(elems);

%% First Plot
subplot(3, 1, 1);
plot(t_plot_range, x_plot_range)
% set graph properties for first plot of solutions against time
title('Time Series');
ylabel('Displacement/m');
xlabel('Time/s');

%% Second Plot
% same trick as before
start_find = 40*T;
end_find = 100*T;
elems = find(t_solve_range>=start_find & t_solve_range<=end_find);
% Plot ranges
% ode45 produced two column matrix with first columsn y solutions, 
% second column dy/dx solutions, slice solutions
xs = x(:, 1);
dxdts = x(:, 2);
x_plot_range = xs(elems);
dxdt_plot_range = dxdts(elems);
subplot(3, 1, 2);
plot(x_plot_range, dxdt_plot_range);
% set graph properties for phase space trajectory plot window
title('Phase Space Trajectory');
xlabel('x/m');
ylabel('dx/dt/ms^-1');

%% Third Plot
% Poincare Section
% mod(X, Y) == 0 check for X divides Y no remainder
start_find = 100*T;
end_find = 1000*T;
elems = find((t_solve_range>=start_find & t_solve_range<=end_find) & mod(t_solve_range, T)==0);
% Plot ranges
% ode45 produced two column matrix with first columns y solutions, 
% second column dy/dx solutions, slice solutions
xs = x(:, 1);
dxdts = x(:, 2);
x_plot_range = xs(elems);
dxdt_plot_range = dxdts(elems);
subplot(3, 1, 3);
plot(x_plot_range, dxdt_plot_range, '.');
%set graph properties for Poincare section plot window
title('Poincare Section')
xlabel('x/m');
ylabel('dx/dt/ms^-1');
axis([-3 3 -3 3])

% Poincare section for non chaotic (steady state) oscillation is a point as
% the oscillator should return to the same place at the end of each period.
% Thus GAMMA = 0.5 corresponds to steady state oscillation, with points
% outside of the chosen range likely a result of transient behaviour
% for chaotic behavious at GAMMA=1.5 the oscillator ends up in a
% different place at the end of each period, hence the smearing in the 
% poincare section

%http://www.yorku.ca/marko/ComPhys/Duffing/Duffing.html
