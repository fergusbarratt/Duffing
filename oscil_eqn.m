
%% Define Duffing Oscillator ODE in form for ode45 in oscil_response.m
function dx = oscil_eqn(t, x)

    % Global variables from oscil_response
    global gamma omega epsilon GAMMA OMEGA;

    %% Definition
    % Build derivatives vector from eq. 3 problem sheet
    dx(1) = x(2);
    dx(2) = -gamma*x(2)+omega^2*x(1)-epsilon*x(1)^3+GAMMA*cos(OMEGA*t);
    
    % Transpose to column vector for ode45
    dx = dx';