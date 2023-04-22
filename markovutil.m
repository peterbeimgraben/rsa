function u = markovutil(s)

% MARKOVUTIL computes Markov utility function for RSA
% function u = markovutil(s)
%
% input :
% s : symbolic sequence 
%
% output :
% u : utility function

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
%
% Reference:
% beim Graben, P.; Sellers, K. K.; Fröhlich, F. & Hutt, A. (2016).
% Optimal estimation of recurrence structures from time series.
% EPL, 114, 38003
% Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors: 
% interweaving dynamical systems and experimental data. 
% Frontiers in Applied Mathematics and Statistics, 3, 11.


P = markovmat(s);
nstat = size(P, 1);

% 1st row
p0r = P(1, :);

% 1st col
pc0 = P(:, 1)';

% compute renormalized entropies
h1r = renosha(p0r);
h1c = renosha(pc0);

% utility function
u = (trace(P) + h1r + h1c) / (nstat + 2);

return