function [r,phi,z] = unsolve(a0,a1,a2)
%UNSOLVE
%INPUT:
%a1,a2,a3 = angles of servos
%x,y,z = converted to cartesian

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
L3=68; %Length from wrist to hand PLUS base centre to shoulder

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

phi = a0;

