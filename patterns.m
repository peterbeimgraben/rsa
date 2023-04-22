function [pattern, dur] = patterns(partition, met);

% PATTERNS computes representative states of recurrence domains
% function [pattern, dur] = patterns(partition, met);
% mean patterns of recurrence domains
% input:
%
% partition : partition: structure array of fields
% met : method for representatives:
%       'cent' : centroids
%       'max'  : maximum norm
%
% outputs:
% pattern : array of recurrence domain patterns
% dur : array of relative pattern durations

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017
% Hochschule Ansbach 2017
% BTU Cottbus-Senftenberg 2018
%
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


% get number of recurrence domains
nd = size(partition, 2);

% total duration
total = 0;

% patterns, excluding "0"
for i = 1 : nd
    
    p = partition(i).symbol;
    if p
        
        dur(p) = size(partition(i).domain, 2);
        total = total + dur(p);
        
        switch met
            
            % centroids
            case 'cent'
                pattern(:, p) = mean(partition(i).domain, 2);
                
            % maximum norm
            case 'max'
                mxno = 0;
                for k = 1 : dur(p)
                    ptt = partition(i).domain(:, k);
                    pn = norm(ptt, Inf);
                    if pn > mxno
                        mxno = pn;
                        pattern(:, p) = ptt;
                    end %if
                end % for
                
            otherwise
                error('patterns() no admissible method');
                return;
                
        end % switch
        
    end %if
    
end

dur = dur / total;

return