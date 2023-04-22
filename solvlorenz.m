function [time, data] = solvlorenz(ti, tf, prec, r, show)

% SOLVLORENZ solves Lorenz ODE
% function [time, data] = solvlorenz(ti, tf, prec, r, show)
%
% inputs:
% initial time  : ti
% final time    : tf
% time step     : prec
% randomize?    : r
% show plot?    : show

nt = prec * (tf - ti + 1);
tint = linspace(ti, tf, nt);

if r > 0

    for i = 1 : r
        % Random initial conditions
        y0(1) = 20 + 0.5 * randn;
        y0(2) = 5 + 0.5 * randn;
        y0(3) = -5 + 0.5 * randn;
        [time, y] = ode45('lorenzeq', tint, y0);
        data(i, :, :) = y';
    end

else

    % The initial conditions below will produce good results
    y0 = [20; 5; -5];    
    [time, y] = ode45('lorenzeq', tint, y0);
    data(1, :, :) = y';

end

if show

    s = size(data);

    figure
    hold on
    for i = 1 : s(1)
        plot(squeeze(data(i,:,:))')
    end

    figure
    hold on
    for i = 1 : s(1)
        plot3(squeeze(data(i, 1, :)), squeeze(data(i, 2, :)), squeeze(data(i, 3, :)))
    end

end

return