function [ s, varargout ] = rsa(data, datasamp, prorange, varargin)

% RSA Recurrence Structure Analysis
% function [ s, varargout ] = rsa(data, datasamp, prorange, varargin)
%
% inputs:
% data : multivariate time series,
%    data(space, time)
% datasamp : epsilon sampling
% prorange : proportion of data range (in percent)
%
% optional:
% 'norm' : pdist norm string,
%       'norm' = 'cosq' uses cosine square dissimiliarity,
%       yet 'norm' = 'symbol' makes dist(0,0) = Inf 
%       for transients in symbolic dynamics
% 'optim' : optimization algorithm,
%       'markov' (default) : Markov chain optimization
%                           (beim Graben et al. 2016)
%       'uniform' : entropy maximization
%                           (beim Graben & Hutt 2013)
% 'show' : {0,1} display results; default = 0
%
% outputs:
% s : symbolic sequence of recurrence domains
%
% optional:
% 1 : ballsizes : epsi
% 2 : utility function : util
%
% example calls:
% s = rsa(y, ds, pr);
% s = rsa(y, 100, 100, 'show', 1);
% s = rsa(y, ds, pr, 'optim', 'uniform');
% [s, e, u] = rsa(y, ds, pr, 'norm', 'cosine');

% see recgram(), recsymdy(), ballsizes(), distmat()

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
    help rsa
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
    
    error('rsa() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;
try, g.optim;     catch g.optim = 'markov';              end;
try, g.show;      catch g.show = 0;                      end;

% compute distance matrix
D = distmat(data, 'norm', g.norm, 'show', g.show);

% compute epsilon test array
epsi = ballsizes(D, datasamp, prorange);

% optimize ball size epsilon
if strcmp(g.optim, 'markov')
    
    [ opt, ~, ~, util ] = maxutil(D, epsi, 'show', g.show);
    
elseif strcmp(g.optim, 'uniform')
    
    [ opt, ~, util ] = maxent(D, epsi, 'show', g.show);
    
else
    
    error('rsa() error: unknown optimziation algorithm: %s', g.optim);
    return
    
end

% optimal recurrence-based symbolic encoding
s = recurrencesymbols(D, opt);

varargout{1} = epsi;
varargout{2} = util;

return
