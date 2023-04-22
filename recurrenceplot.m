function R = recurrenceplot(dmat, epsilon, varargin)

% RECURRENCEPLOT creates recurrence plot.
% function R = recurrenceplot(dmat, epsilon, varargin)
% creates recurrence matrix (recurrence plot) R
% from distance matrix
%
% inputs:
% dmat : distance matrix
% epsilon : ball size
%
% optional
% 'show'  : {0,1} display results
%
% output : (sparse) recurrence matrix R

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2013
%
% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.

if nargin < 1
    help recurrenceplot
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
    
    error('recurrenceplot() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.show;      catch g.show = 0;                         end;

% calculate recurrence matrix
R = sparse(dmat < epsilon);

if g.show
    
    figure
    set(gcf, 'Renderer', 'zbuffer')
    surface(1 - R, 'EdgeColor', 'none')
    set(gca, 'FontSize', 14)
    xlabel('time / samples', 'Fontsize', 14)
    ylabel('time / samples', 'Fontsize', 14)
    axis([1 size(R, 1) 1 size(R, 2)])
    axis square
    colormap(gray)
    
end

return

