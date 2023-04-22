function h = shannonutil(sym)

% SHANNONUTIL renormalized Shannon utility function of symbolic dynamics
% function h = shannonutil(sym)
%
% inputs:
% sym : symbolic sequence
%       note, admissible symbols 0..n
%
% output :
% h : renormalized Shannon entropy

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
%
% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.

if nargin < 1
    help shannonutil
    return
end

% get data size
nt = size(sym, 2);

% detect plateus
for i = 1 : nt
    idx(i) = size(find(sym == i - 1), 2);
end

% compress and normalize to relative frequencies
pri = idx(find(idx)) / nt;

% alphabet's cardinality 
nsy = size(pri, 2);

% compute renormalized Shannon entropy H1
h = - pri * log(pri)' / nsy;

return
