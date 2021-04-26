function [bool,a0,a1,a2] = solve(x,y,z)

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
L3=68; %Length from wrist to hand PLUS base centre to shoulder
bool = 1;
%% Main
% Solve top-down view
[r,th0] = cart2polar(y,x);

r = r - L3;

% In arm plane, convert to polar
[R,ang_P] = cart2polar(r,z);

[bool1,B] = cosangle(L2, L1, R);
[bool2,C] = cosangle(R, L1, L2);

% if one of bool1or2 is zero bool = 0
if (~bool1 || ~bool2)
    bool = 0;
end

if (bool == 0)
    a0 = 0;
    a1 = 0;
    a2 = 0;
else
    a0 = th0;
    a1 = ang_P + B;
    a2 = C + a1 - pi;
end