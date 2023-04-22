function g = goedel(s, nsymbols);

% GOEDEL computes Goedel number of symbolic sequence
% function g = goedel(s, nsymbols);
%
% inputs : 
% s : symbolic sequence
% nsymbols : cardinality of alphabet
%
% output :
% g : Goedel code of string s

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015

% Horner scheme
g = 0;
for i = 1 : length(s)        
    g = nsymbols * g + s(i);
end

return