function dist = hausdorff(A, B, varargin)

% HAUSDORFF computes Hausdorff distance between two point clouds
% function dist = hausdorff(A, B, varargin)
%
% inputs :
% A, B : point sets
%
% optional:
% 'norm' : pdist2 norm string
% 'show' : {0,1} display results
%
% output :
% dist : hausdorff( A, B )
% see pdist2()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015

% check statistics toolbox
D = 0;
if ~exist('pdist', 'file')
    
    error('hausdorff() error: statistics toolbox required.\n');
    return
    
end

if nargin < 1
    help hausdorff
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
    
    error('hausdorff() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;
try, g.show;      catch g.show = 0;                      end;


% calculate the pairwise distances

if strcmpi(g.norm, 'cosq')
    
    D = pdist2(A, B, @cosq);
        
else
    
    D = pdist2(A, B, g.norm);
    
end

% Hausdorff
dist = max(max(min(D, [], 1)), max(min(D, [], 2)));

if g.show
    
    figure
    imagesc(D)
    
end

return