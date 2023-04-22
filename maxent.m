function [ opteps, varargout ] = maxent(dmat, epsilon, varargin)

% MAXENT maximizes Shannon entropy for optimal ball size
% of recurrence grammar
% function [ opteps, varargout ] = maxent(dmat, epsilon, varargin)
%
% inputs:
% dmat : distance matrix
% epsilon : vector of epsilon neighborhoods
%
% optional
% 'show'    : {0,1} display results; default = 0
%
% output :
% opteps : optimal epsilon
%
% optional:
% 1 : maximal entropy : emax
% 2 : utility function : u
% see ballsize()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
%
% Reference:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.

if nargin < 1
    help maxent
    return
end

% Read optional arguments
try
    
    options = varargin;
    for index = 1 : length(options)
        if iscell(options{index}) & ~iscell(options{index}{1})
            options{index} = { options{index} };
        end;
    end;
    if ~isempty( varargin )
        g = struct(options{:});
    else
        g = [];
    end
    
catch
    
    error('maxent() error: calling convention {''key'', value, ... } error');
    return;
    
end;

% get data size
nt = size(dmat, 1);
ne = size(epsilon, 2);

try, g.show;       catch g.show = 0;                   end;

% compute RSA for all epsilons
for i = 1 : ne
    
    s(i, :) = recurrencesymbols(dmat, epsilon(i));
    
end 

% compute entropy utility for all epsilons
for k = 1 : ne
    
    u(k) = shannonutil(s(k, :)); 
    
end

[xmax, imax] = max(u);
u = u / xmax;
opteps = epsilon(imax);
varargout{1} = xmax;
varargout{2} = u;

% plot results
if g.show
   
    figure
    colormap(colorcube)
    imagesc([1 nt], [epsilon(1) epsilon(ne)], s, [0 10])
    set(gca, 'FontSize', 18)
    xlabel('time', 'Fontsize', 24)
    ylabel('\epsilon', 'Fontsize', 24)
    
    figure
    plot(epsilon, u, 'k-', 'Linewidth', 2)
    axis([epsilon(1) epsilon(end) 0 1.1])
    set(gca, 'FontSize', 18)
    xlabel('\epsilon', 'Fontsize', 24)
    ylabel('utility', 'Fontsize', 24)
    
    hold on
    
end % of show

return
