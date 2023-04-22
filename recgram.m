function G = recgram(R);

% RECGRAM creates recurrence grammar from recurrence plot.
% function G = recgram(R);
% creates recurrence grammar from recurrence plot / recurrence matrix R
%
% input:
% R : recurrence matrix of data
%
% output:
% G : recurrence grammar

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2014
% fully vectorized by Norbert Marwan, PIK 2013

% Reference:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.

if nargin < 1
    help recgram
    return
end

% get size of recurrence plot
r = size(R, 1);

% initialize first rule (l = rule number)
l = 1;

% consider only one triangle of the RP
R = triu(R);

% find indices of entries
i = find(R);

% find zeros
i0 = find(~R);

% mask all entries in RP with its linear position
R2 = double(full(R));
R2(R2 ~= 0) = i;

% correct from linear to colum-wise position of entries
R3 = R2 - repmat(linspace(0, r * (r - 1), r), r, 1);

% the zeros
R3(i0) = Inf;

% determine smallest column index
[dest i] = min(R3);

% delete first entry
if ~isinf(dest)
    
    i3 = sub2ind([r r], dest, 1 : r);
    R3(i3) = Inf;
    
else
    
    error('recgram(): couldn''t create recurrence grammar.')
    return
    
end

% sort the values and start from the last column
R4 = fliplr(sort(R3, 'descend'));

% create a matrix from the smallest column index, start with the last column
i = repmat(fliplr(dest), r, 1);

% create recurrence grammar matrix
G = [R4(:), i(:)];

% remove all unneeded entries
G(G(:, 1) == Inf, :) = [];


% get size of recurrence grammar
try
    
    gs = size(G, 1);
    
catch
    
    % error message
    error('recgram(): couldn''t create recurrence grammar, increase epsilon!\n')
    return
    
end

return


