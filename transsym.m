function sr = transsym(s)

% TRANSSYM transforms symbolic dynamics to gap-less code
% function sr = transsym(s);
%
% input:
% s : symbolic sequence
%
% output:
% sr : recoded symbolic sequence
% see recsymdy()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2014.
% Improved by Mariia Fedotenkova, 2015 INRIA Nancy.

% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.

if nargin < 1
    help transsym
    return
end

% unique elements in symbolic sequence
us = unique(s);

% skip zeros
us = us(us ~= 0);
if length(s) > 1
    
    % substitute unique elements with their indices
    [~, sr] = ismember(s, us);
    
else
    
    % if there are only zeros, leave sequence as it is
    sr = s;
    
end

return
