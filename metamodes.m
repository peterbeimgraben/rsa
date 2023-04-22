function [ modes, varargout ] = metamodes(data, sym, varargin);

% METAMODES computes representatives of recurrence domains.
% function [ modes, varargout ] = metamodes(data, sym);
%
% input:
%
% data : multivariate time series, data(trials, space, time)
% sym  : symbolic dynamics of data created with recgram, sym(trials, time)
%
% optional:
% 'normal' : {0,1} normalization; default = 0
% 'method' : {'cent', 'max'} representatives:
%       'cent' : centroids
%       'max'  : maximum norm
%       default : cent
%
% output:
%
% modes : metastable modes matrix ('factors'), modes(number, dimension)
%
% optional:
% durations
%
% see hausdorff(), recgram(), recdomains(), hdcluster(), patterns()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
% BTU Cottbus-Senftenberg 2018

if nargin < 1
    help metamodes
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
    
    error('metamodes() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.normal;      catch g.normal = 0;            end;
try, g.method;      catch g.method = 'cent';       end;

% check for trial number
if length(size(data)) == 2
    
    tmp(1, :, : ) = data(:, :);
    data = tmp;
    
end

% get size of data
r = size(data);

ntrials = r(1);    % number of trials
d = r(2);          % phase space dimension
nt = r(3);         % number of samples


% total number of recurrence domains
nr = max(max(sym));

% concatenate time series and symbolic dynamics
y1 = permute(data, [2 3 1]);
y2 = reshape(y1, d, []);
s2 = reshape(sym', 1, []);

% unify partitions
partition = recdomains(y2, s2);

% modes ("factors") and durations
[modes, dur] = patterns(partition, g.method);

% normalization
if g.normal
    
    modes = normalize(modes);
    
end

varargout{1} = dur;

return
