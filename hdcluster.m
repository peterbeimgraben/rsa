function s = hdcluster(data, sym, theta, varargin)

% HDCLUSTER recurrence domain Hausdorff clustering
% function s = hdcluster(data, sym, theta, varargin)
% clustering of recurrence domains by means of their Hausdorff distance
%
% input:
%
% data  : ensemble of multivariate time series, 
%    data(realization, space, time)
% sym : ensemble of symbolic dynamics of data created with recgram, 
%    sym(realization, time)
% theta : distance threshold
%
% optional
% 'norm' : pdist2 norm string
% 'didi'  : {0,1} display distance distribution
%
% output:
%
% s : symbolic sequence of recurrence domains
% see Hausdorff(), recgram()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015
% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.
% Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors: 
% interweaving dynamical systems and experimental data. 
% Frontiers in Applied Mathematics and Statistics, 3, 11.


if nargin < 1
    help hdcluster
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
    
    error('hdcluster() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;
try, g.didi;      catch g.didi = 0;                      end;

% check for trial number
if length(size(data)) == 2
    
    tmp(1, :, : ) = data(:, :);
    data = tmp;
    
end

% get size of data
r = size(data);
ntrials = r(1);         % number of trials
nt = r(3);              % number of samples
d = r(2);               % phase space dimension
n = ntrials * nt;       % total number of samples

% recode realizations
s1(1, :) = sym(1, :);
for i = 2 : ntrials
    for j = 1 : nt
        if sym(i, j) == 0
            s1(i, j) = sym(i, j);
        else
            s1(i, j) = sym(i, j) + (i - 1) * nt;
        end
    end
end

% concatenate time series and symbolic dynamics
y1 = permute(data, [2 3 1]);
y2 = reshape(y1, d, []);
s2 = reshape(s1', 1, []);

% unify partitions
partition = recdomains(y2, s2);
D = hdist(partition, partition, 'norm', g.norm);

if g.didi
    figure
    hist(reshape(D, 1, []));
end

% thresholding
R = (D < theta);

% make recurrence grammar for overlapp
G = recgram(R);

% get grammar size
gs = size(G, 1);

% recode
s3 = s2;

% apply recurrence grammar
% rewriting through two iterations
for k = 1 : 2
    
    % loop through recurrence grammar
    for i = 1 : gs
        
        % get all occurrences of l.h.s. of rule i in string s
        sy1 = partition(G(i, 1) + 1).symbol;
        sy2 = partition(G(i, 2) + 1).symbol;
        
        idx = find(s3 == sy1);
        
        % if there are any
        if idx
            
            % rewrite l.h.s. with r.h.s.
            s3(idx) = sy2;
            
        end % of if
        
    end % of rule loop
    
end % of recursion

% remove gaps
sr = transsym(s3);
s = reshape(sr, nt, ntrials)';

return