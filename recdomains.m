function partition = recdomains(data, sym);

% RECDOMAINS partitions multivariate time series into recurrence domains
% function partition = recdomains(data, sym);
% partitions multivariate time series into recurrence domains
% obtained by recurrence grammar RECGRAM
%
% input:
%
% data : multivariate time series, data(space, time)
% sym  : symbolic dynamics of data created with recgram
%
% output:
%
% partition: structure array of fields
% partition(i).symbol : label of cell i
% partition(i).domain : samples contained in cell i

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017

% References:
% beim Graben, P. & Hutt, A. (2013). Detecting recurrence domains of
% dynamical systems by symbolic dynamics.
% Physical Review Letters, 110, 154101.
% beim Graben, P. & Hutt, A. (2015). Detecting event-related recurrences 
% by symbolic analysis: Applications to human language processing.
% Philosophical Transactions of the Royal Society London, A373, 201400897.
% Hutt, A. & beim Graben, P. (2017). Sequences by metastable attractors: 
% interweaving dynamical systems and experimental data. 
% Frontiers in Applied Mathematics and Statistics, 3, 11.


% get data size
nt = size(data, 2);

% detect partition cells
k = 1;
for i = 1 : nt
    
    idx{i} = find(sym == i - 1);
    
    if ~isempty(idx{i})
        partition(k).symbol = i - 1;
        partition(k).domain = data(:, idx{i});
        k = k + 1;
    end
    
end

return