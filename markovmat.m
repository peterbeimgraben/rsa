function P = markovmat(s)

% MARKOVMAT computes Markov transition matrix from symbolic sequence
% function P = markovmat(s)
%
% input : 
% s : symbol sequence 
%
% output :
% P : Markov transition matrix 

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
%
% Reference:
% beim Graben, P.; Sellers, K. K.; Fröhlich, F. & Hutt, A. (2016).
% Optimal estimation of recurrence structures from time series.
% EPL, 114, 38003
% Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors: 
% interweaving dynamical systems and experimental data. 
% Frontiers in Applied Mathematics and Statistics, 3, 11.


nsamples = length(s);
alpha = unique(s);

if ~ismember(0, alpha)
    alpha = [0 alpha];
end

nsymbols = length(alpha);

% compute symbol distribution
w1 = wordstat(s, nsymbols, 1);

% compute bigram distribution
w2 = wordstat(s, nsymbols, 2);

P = eye(nsymbols);

% compute Markov transition matrix
for i = 1 : nsymbols
    
    for j = 1 : nsymbols
        
        gji = goedel([j - 1, i - 1], nsymbols) + 1;
        
        if w1(j)
            P(i, j) = w2(gji) / w1(j);
        end
        
    end
    
end

P = full(P);

return
