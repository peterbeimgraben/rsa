function D = cosq(XI, XJ);

%   COSQ cosine square distance function
%   function D = cosq(XI, XJ)
%   taking as arguments a 1-by-N vector XI containing a single row of X, an
%   M2-by-N matrix XJ containing multiple rows of X, and returning an
%   M2-by-1 vector of distances D2, whose Jth element is the distance
%   between the observations XI and XJ(J,:).
%
% inputs:
% XI : 1-by-N vector
% XJ : M2-by-N matrix

% (C) Peter beim Graben, Humboldt-Universität zu Berlin 2017

[a, b] = size(XJ);
xin = norm(XI);
D = zeros(a, 1);

for j = 1 : a
    
    xjn = norm(XJ(j, :));
    D(j) = 1 - (XI * XJ(j, :)' / (xin * xjn))^2;
    
end

return
