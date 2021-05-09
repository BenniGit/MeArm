function [bool,a0,a1,a2] = solve(r,phi,z)
% SOLVE
% INPUT:
% r = Radius
% phi = angle
% z = value of z
% OUTPUT:
% a0 = angle of the base
% a1 = angle of the shoulder
% a2 = angle of the elbow
%
% Get the position of the robot arm in a cylindrical 
% coordinate system and calculates the angles of the
% Base, the Shoulder and the Elbow

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
Lgrip=68; %Length from wrist to hand PLUS base centre to shoulder
bool = 1;
%% Main
% Calculate the real length of the triangle that has to be solved
r = r - Lgrip;

% Convert to polar
[L3,phiB] = cart2polar(r,z);

% We use the Law of cosine to Calculate the missing angles
% the variables bool 1 and bool2 give back a 0 or 1
% these values will indicate if the system is solveable 
% or not. 
[bool1,phiSHI] = cosangle(L2, L1, L3);
[bool2,phi12] = cosangle(L3, L1, L2);

% if one of bool 1or2 is zero bool = 0
if (~bool1 || ~bool2)
    bool = 0;
end

% if bool is zero set these valus to nan
if (bool == 0)
    a0 = nan;
    a1 = nan;
    a2 = nan;
else
    % a0 is directly phi
    a0 = phi;
    %fprintf('Base Angle in solve method %d \n',a0);
    
    % a1 is the sum of phiB and phiSHI
    a1 = phiB + phiSHI;
    % a2 will be calculated with the triangle rule that the sum
    % of all angles has to be equal to pi
    a2 = pi - a1 - phi12;
    % these function is going to make sure that the angles will be 
    % in the working range of the robot
    [a1,a2] = correctangles(a1,a2);
    % This is a correction we had to add because if the angle is zero
    % the servo has to at the position 1. So that's just the inverse
    a1 = pi-a1;
    % This is more or less the same with the angle a2 but a bit more
    % complex
    a2 = map(a2,0,pi/2,pi,pi/2);
    %fprintf('Shoulder Angle in solve method %d \n',a1);
    %fprintf('Elbow Angle in solve method %d \n',a2);
end


    
end