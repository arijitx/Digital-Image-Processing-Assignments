function res = LiCS( im )
%utility for linear contrast stretch
%   Detailed explanation goes here

    minp = min(min(im));
    maxp = max(max(im));
    res = ((im - minp))/(maxp- minp);
end

