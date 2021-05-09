function [r,phi,z] = unsolve(a0,a1,a2)
% UNSOLVE
% INPUT:
% a0,a1,a2 = angles of servos
% OUTPUT:
% r = Radius
% phi = angle
% z = value of z 
%
% The function 'unsolve' get the three angles of the servo and calculates
% these values to a cylindrical coordinate system.
% With this you can determine the position of the robot with the
% information of the servo angles.

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
L3=68; %Length from wrist to hand PLUS base centre to shoulder

% We have to transform the angles because the function gets values between
% 0 and 1
a0 = a0*pi;
a1 = map(a1,0,1,pi,0);
a2 = map(a2,0.5,1,pi/2,0);

%% Main

%transform with shoulder and elbow angle
[u01,v01] = polar2cart(L1,a1);
[u12,v12] = polar2cart(L2,a2);

%sum up all u and all v values
r = u01 + u12 + L3;
z = abs(v01) - abs(v12);

% angle of the servo is directly the Base angle
phi = a0;

