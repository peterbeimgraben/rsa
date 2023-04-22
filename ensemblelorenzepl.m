% Symbolic Recurrence Partition Analysis of Lorenz ensemble ODE

% ENSEMBLELORENZEPL solves Lorenz ODE for multiple realizations
% according to beim Graben et al. (2016) - Supplement

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
ti = 0;
tf = 10;
prec = 50;
ntrials = 50;

% RSA params
datasamp = 100;
prorange = 20;

[t, y] = solvlorenz(ti, tf, prec, ntrials, 0);

n = size(y);
nt = size(y, 3);

col = 15;

% Hausdorff threshold
thres = 1.5;

% data size
nt = size(y, 3);

% carry out RSA!
% s = ensemblersa(y, datasamp, prorange);     % default
s = ensemblersa(y, datasamp, prorange, 'cluster', thres);  
%           including Hausdorff clustering

% additional Hausdorff clustering
% sc = hdcluster(y, s, thres);
% s = sc;

% total number of recurrence domains
nr = max(max(s));

% show partition
figure(1)
cm = colormap;
m = size(cm, 1);
set(gca, 'FontSize', 18)
view(17,-17)
xlabel('x_1', 'Fontsize', 24)
ylabel('x_2', 'Fontsize', 24)
zlabel('x_3', 'Fontsize', 24)
hold on
for i = 1 : ntrials
    for j = 1 : nt
        
        c = mod(col * s(i, j), m) + 1;
        plot3(y(i, 1, j), y(i, 2, j), y(i, 3, j), 'o', ...
            'MarkerEdgeColor', cm(c, :),...
            'MarkerFaceColor', cm(c, :),...
            'MarkerSize', 2) %2
        
    end
end

% show symbolic dynamics
figure(2)
imagesc(s, [0, nr])
set(gca, 'FontSize', 18)
xlabel('time / sample', 'Fontsize', 24)
ylabel('trial', 'Fontsize', 24)
