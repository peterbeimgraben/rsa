function ydot = lorenzeq(t, y)

% LORENZEQ Equation of the Lorenz chaotic attractor.
%   ydot = lorenzeq(t, y).
%   The differential equation is written in almost linear form.

% typical parameters
SIGMA = 10.0;
RHO = 28.0;
BETA = 8.0/3.0;

% Lorenz (1963)
A = [
    -SIGMA,     SIGMA,  0;
    RHO - y(3), -1,     0;
    y(2),       0,      -BETA
    ];

ydot = A * y;

return
