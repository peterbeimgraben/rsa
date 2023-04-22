% LORENZEPL carries out RSA of Lorenz ODE
% according to beim Graben et al. (2016)

% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.
% beim Graben, P.; Sellers, K. K.; Fröhlich, F. & Hutt, A. (2016). 
% Optimal estimation of recurrence structures from time series. 
% EPL, 114, 38003 

clear all
close all
clc

% integration params
ti = 0;         % start time
tf = 20;        % end time
prec = 100;     % delta t

% RSA params
% suitable setting
ds = 10;  % threshold sampling
pr = 7;   % threshold range: 
          % percentage of available phase space volume

% solve Lorenz ODE
[t, y] = solvlorenz(ti, tf, prec, 0, 0);
y = squeeze(y);
nt = size(y, 2);

% carry out RSA!
% recommended 1st attempt
% for probing ball size sampling
% however also very slow
% s = rsa(y, 100, 100, 'show', 1);          % test
% s = rsa(y, ds, pr, 'show', 1);            % default: Markov optimization
s = rsa(y, ds, pr);                         % default: Markov optimization
% s = rsa(y, ds, pr, 'optim', 'uniform');   % entropy optimization          
% s = rsa(y, ds, pr, 'norm', 'cosq');       % default + cosine similarity

% plot Lorenz data
figure
set(gcf, 'Units', 'normalized')
set(gcf, 'Position', [0.01 0.1 0.43 0.65]);

% plot time series
subplot(2, 1, 1)
plot(y', 'Linewidth', 1.3)
xlabel('time / samples', 'Fontsize', 24)
ylabel('x_1, x_2, x_3', 'Fontsize', 24)
axis([0 nt -30 70])
set(gca, 'FontSize', 18)
pos = get(gca, 'Position');
grid on

% plot segmentation
subplot(2, 1, 2)
nr = max(s);    % number of symbols
imagesc(s, [0 nr])
set(gca, 'FontSize', 18)
set(gca, 'Position', pos - [0 0.2 0 0.30])
set(gca, 'Visible', 'off')
colormap('default')
