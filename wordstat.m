function [ words ] = wordstat(s, nsymbols, wl);

% WORDSTAT computes word statistics of symbolic sequence
% function [ words ] = wordstat(s, nsymbols, wl);
%
% inputs :
% s : symbolic sequence
% nsymbols : cardinality of alphabet
% wl : word length
%
% output :
% words : distribution of word frequencies

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015

nsamples = length(s);
nwords = nsymbols^wl;
words = sparse(1, nwords);

for t = 1 : nsamples - wl + 1
    
    % compute Goedel number of word g
    g = goedel(s(t : t + wl - 1), nsymbols) + 1;
    
    % increment word g
    words(g) = words(g) + 1;
    
end

return
