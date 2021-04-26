function [x,y,z] = unsolve(a0,a1,a2)
%UNSOLVE
%INPUT:
%a1,a2,a3 = angles of servos
%x,y,z = converted to cartesian

%% Some Variables
L1=80; %Shoulder to elbow length
L2=80; %elbow to wrise length
L3=68; %Length from wrist to hand PLUS base centre to shoulder

%% Main

%transform with shoulder and elbow angle
[u01,v01] = polar2cart(L1,a1);
[u12,v12] = polar2cart(L2,a2);

%sum up all u and all v values
u = u01 + u12 + L3;
v = v01 + v12;

% Consider Base angle - x/y is reversal!
[y,x] = polar2cart(u,a0);
z = v;

