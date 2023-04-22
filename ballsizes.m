function eparray = ballsizes(dmat, datasamp, prorange)

% BALLSIZES returns epsilon array for RSA
% function eparray = ballsizes(dmat, datasamp, prorange)
%
% inputs:
% dmat : distance matrix
% datasamp : epsilon sampling
% prorange : proportion of data range (in percent)
%
% output :
% eparray : epsilon array
%
% example call:
% eparray = ballsizes(dmat, 100, 100)
%   computes 100 samples covering 100% of data range

% see distmat()

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2015
%
% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Proceedings of the Royal Society London, A373, 201400897.

D3 = dmat(find(dmat));
ymax = max(max(D3));
ymin = min(min(D3));
yrange = ymax - ymin;
el = ymin / 2;
eh = prorange * yrange / 100;

% check for proper interval
if el < eh
    eparray = linspace(el, eh, datasamp);
else
    eparray = [1 1];
end

return
