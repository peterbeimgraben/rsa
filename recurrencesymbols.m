function s = recurrencesymbols(dmat, epsilon)

% RECURRENCESYMBOLS creates symbolic dynamics from recurrence domains. 
% function s = recurrencesymbols(dmat, epsilon)
%
% input:
% dmat : distance matrix
% epsilon : ball size
%
% output:
% s : symbolic sequence of recurrence domains
% see recgram(), recsymdy()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015

% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.


if nargin < 1
    help recurrencesymbols
    return
end

% compute recurrence plot for epsilon
R = recurrenceplot(dmat, epsilon);

% recurrence grammar
G = recgram(R);

% symbolic dynamics
s = recsymdy(size(dmat, 1), G);

return