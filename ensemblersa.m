function [ s, varargout ] = ensemblersa(data, datasamp, prorange, varargin)

% ENSEMBLERSA Ensemble Recurrence Structure Analysis
% function [ s, varargout ] = ensemblersa(data, datasamp, prorange, varargin)
%
% inputs:
% data  : ensemble of multivariate time series,
%    data(realization, space, time)
% datasamp : epsilon sampling
% prorange : proportion of data range (in percent)
%
% optional:
% 'norm' : pdist norm string,
%       yet 'norm' = 'symbol'
%       makes dist(0,0) = Inf for transients in symbolic dynamics
% 'optim' : optimization algorithm,
%       'markov' (default) : Markov chain optimization
%                           (beim Graben et al. 2016)
%       'uniform' : entropy maximization
%                           (beim Graben & Hutt 2013)
% 'show' : {0,1} display results; default = 0
% 'cluster' : Hausdorff clustering; threshold parameter
%                           (beim Graben & Hutt 2015)
%                           (Hutt & beim Graben 2017)
%
% outputs:
% s : symbolic sequence array of recurrence domains
% optional:
% 1 : ball size array : eps
% 2 : utility functions : util
%
% example calls:
% s = ensemblersa(y, ds, pr);
% s = ensemblersa(y, ds, pr, 'optim', 'uniform');
% s = ensemblersa(y, ds, pr, 'cluster', 13.5);
% [s, e, u] = ensemblersa(y, ds, pr, 'norm', 'cosine');

% see rsa(), hdcluster(), recgram(), recsymdy(), ballsizes(), distmat()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017

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
% Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors:
% interweaving dynamical systems and experimental data.
% Frontiers in Applied Mathematics and Statistics, 3, 11.


if nargin < 1
    help ensemblersa
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
    
    error('ensemblersa() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;
try, g.optim;     catch g.optim = 'markov';              end;
try, g.show;      catch g.show = 0;                      end;
try, g.cluster;   catch g.cluster = 0;                   end;


% get data size
ndata = size(data);

% carry out RSA!
for j = 1 : ndata(1)
    
    fprintf('optimize ball size for realization %d\n', j)
    [S, E, U] = rsa(squeeze(data(j, :, :)), datasamp, prorange, ...
        'norm', g.norm, 'optim', g.optim);
    s(j, :) = S;
    e(j, :) = E;
    u(j, :) = U;
    
end

% Hausdorff Clustering
if g.cluster
    
    sc = hdcluster(data, s, g.cluster);
    s = sc;
    
end

% plot results
if g.show
    
    figure
    plot(e', u')
    axis tight
    set(gca, 'FontSize', 18)
    xlabel('\epsilon', 'Fontsize', 24)
    ylabel('utility', 'Fontsize', 24)
    
    hold on
    
end % of show

varargout{1} = e;
varargout{2} = u;

return
