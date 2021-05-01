function [bool,a0,a1,a2] = solve(r,phi,z)

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
Lgrip=68; %Length from wrist to hand PLUS base centre to shoulder
bool = 1;
%% Main

r = r - Lgrip;

% In arm plane, convert to polar
[L3,phiB] = cart2polar(r,z);

[bool1,phiSHI] = cosangle(L2, L1, L3);
[bool2,phi12] = cosangle(L3, L1, L2);

% if one of bool1or2 is zero bool = 0
if (~bool1 || ~bool2)
    bool = 0;
end

if (bool == 0)
    a0 = nan;
    a1 = nan;
    a2 = nan;
else
    a0 = phi;
    fprintf('Base Angle in solve method %d \n',a0);
  
    a1 = phiB + phiSHI;
    a2 = pi - a1 - phi12;
    [a1,a2] = correctangles(a1,a2);
end


    
end