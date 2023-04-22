function v = normalize(w)

% NORMALIZE projects data vectors onto unit sphere
% function v = normalize(w)
% normalizes set of column vectors w w.r.t. 2-norm
%
% inputs:
% w : set of column vectors
%
% output:
% v : set of column vectors

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2014

n = size(w, 1);

d = diag(sqrt(w' * w))';
q = repmat(d, n, 1);

v = w ./ q;

return