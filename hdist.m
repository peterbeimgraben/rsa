function D = hdist(partition1, partition2, varargin)

% HDIST computes Hausdorff distances of two partitions
% function D = hdist(partition1, partition2, varargin)
% computes Hausdorff distance/dissimilarity matrix of two partitions of
% recurrence domains obtained by recurrence grammar RECGRAM
%
% input:
% partition1, partition2 : two partition structure arrays obtained by
% RECDOMAINS
% optional:
% 'norm' : pdist2 norm string
%
% output:
% D : Hausdorff dissimilarity matrix
% see Hausdorff()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017

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
    help hdist
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
    
    error('hdist() error: calling convention {''key'', value, ... } error');
    return;
    
end;

try, g.norm;      catch g.norm = 'euclidean';            end;


% get partition sizes
ncell1 = size(partition1, 2);
ncell2 = size(partition2, 2);


% compute Hausdorff dissimilarity matrix
for i = 1 : ncell1
    
    for j = 1 : ncell2
        
        wi = partition1(i).domain;
        wj = partition2(j).domain;
        
        D(i, j) = hausdorff(wi', wj', 'norm', g.norm);
        
    end
    
end

% delete 1st row and 1st column
D(1, :) = [];
D(:, 1) = [];

return