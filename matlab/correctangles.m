function [aSH,aEL] = correctangles(a1,a2)
% CORRECTANGLES
% INPUT:
% a1 = angles shoulder
% a2 = angle elbow
% OUTPUT:
% aSH = corrected angle Shoulder
% aEl = corrected angle Elbow
%
% Correct the angles from the Shoulder and the Elbow if the angles are not
% in the working range 

% If a1 is bigger then pi set a1 to pi and if it is lower then 0 set aSH to
% 0.
if (a1>pi)
    aSH = pi;
elseif (a1<0)
    aSH = 0;
else
    aSH = a1;
end
% Same here with the Elbow Angle
if (a2>pi/2)
    aEL = pi/2;
elseif (a2<0)
    aEL = 0;
else
    aEL = a2;
end

end

