function D = distmat(data, varargin)

% DISTMAT computes distance matrix of trajectory for RSA
% D = distmat(data, varargin)
%
% input:
% data(space, time)
%
% optional:
% 'norm' : pdist norm string,
%       'norm' = 'cos uses cosine dissimiliarity,
%       yet 'norm' = 'symbol' makes dist(0,0) = Inf 
%       for transients in symbolic dynamics
% 'show' : {0,1} display results
%
% output:
% D : distance matrix
% see pdist()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015

% check statistics toolbox
D = 0;
if ~exist('pdist', 'file')
    
    error('distmat() error: statistics toolbox required.\n');
    return
    
end

if nargin < 1
    help distmat
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
    
    error('distmat() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;
try, g.show;      catch g.show = 0;                      end;

% get number of sampling points
nt = size(data, 2);

% if 'symbolic norm': recode transients 0 -> Inf
% change to 'cityblock' norm
if strcmpi(g.norm, 'symbol')
    
    data(find(data == 0)) = Inf;
    g.norm = 'cityblock';

end

% calculate the pairwise distances
% if 'cos' invoke by handle
if strcmpi(g.norm, 'cos')
    
    D = pdist(data', @cosq);
    
else

    D = pdist(data', g.norm);

end


% make squareform of the distances
D = squareform(D);

if g.show
        
    figure
    imagesc(D)
    
end

return
