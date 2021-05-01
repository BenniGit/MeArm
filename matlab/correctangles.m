function [aSH,aEL] = correctangles(a1,a2)
%CORRECTANGLES Summary of this function goes here
%   Detailed explanation goes here

if (a1>pi/2)
    aSH = pi/2;
elseif (a1<0)
    aSH = 0;
    fprintf('AngleShoulder is smaller then zero %d \n',a1');
else
    aSH = a1;
end

if (a2>pi/2)
    aEL = pi/2;
elseif (a2<0)
    aEL = 0;
    fprintf('AngleElbow is smaller then zero  %d \n',a2');
else
    aEL = a2;
end

end

