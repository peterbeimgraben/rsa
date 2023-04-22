function h = renosha(p)

% RENOSHA computes renormalized Shannon entropy from Markov chain
% function h = renosha(p)
%
% input :
% p : symbol distribution
%
% output :
% h : renormalized Shannon entropy 

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015
%
% Reference:
% beim Graben, P.; Sellers, K. K.; Fröhlich, F. & Hutt, A. (2016). 
% Optimal estimation of recurrence structures from time series. 
% EPL, 114, 38003 

p(1) = [];
n = length(p);

h = 0;
if find(p)
    
    % renormalize against transients
    pr = p / sum(p);
    
    % compute Shannon entropy H
    for i = 1 : n
        if pr(i)
            h = h - pr(i) * log(pr(i));
        end
    end
    
    if n > 1
        h = h / log(n);
    end
    
end

return
