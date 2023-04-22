function s = recsymdy(nsamp, G, varargin);

% RECSYMDY creates symbolic dynamics from recurrence grammar.
% function s = recsymdy(nsamp, G, varargin);
%
% inputs:
% nsamp : number of sampling points in time series
% G : recurrence grammar
%
% optional
% 'show'  : {0,1} display results
%
% output:
% s : symbolic sequence of recurrence domains
% see recgram()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017

% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.

if nargin < 1
    help recsymdy
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
    
    error('recsymdy() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.show;      catch g.show = 0;                         end;


% get size of recurrence grammar
gs = size(G, 1);

% initialize symbolization
% create sequence of time indices
s = 1 : nsamp;

% apply recurrence grammar
% rewriting through two iterations
for k = 1 : 2
    
    % loop through recurrence grammar
    for i = 1 : gs
    
        % get all occurrences of l.h.s. of rule i in string s
        idx = find(s == G(i, 1));
        
        % if there are any
        if idx
            % rewrite l.h.s. with r.h.s.
            s(idx) = G(i, 2);
        end % of if
        
    end % of rule loop
    
end % of recursion

% map transients onto '0'
sp = s;
df = diff(sp);
if df(end) == 1
    sp = [sp sp(end) + 1];
else
    sp = [sp sp(end)];
end
df = diff(sp);
sp(find(df == 1)) = 0;
sp(end) = [];

% gap-less transformation 
spp = transsym(sp);

if g.show
    
    time = 1 : r;
    figure
    plot(time, s, 'r-', time, sp, 'g-', time, spp, 'b-', 'LineWidth', 2)
    
end

s = spp;

return
