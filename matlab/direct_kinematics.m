j4=360-(j2+j3);
j=[j1 j2 j3 j4;2 0 0 0;0 10 10 2;90 0 0 0];

function [Mdh] = DHmatrix(theta,d,a,alpha)
%DHMATRIX Summary of this function goes here
%   Detailed explanation goes here
%   inputannya DH parameter yaa
Mdh=[cosd(theta) -sind(theta)*cosd(alpha) sind(theta)*sind(alpha) a*cosd(theta);
     sind(theta) cosd(theta)*cosd(alpha)  -cosd(theta)*sind(alpha) a*sind(theta);
     0,sind(alpha),cosd(alpha),d;
     0,0,0,1];
end

function [ FK ] = DHkine(j)
%collum 1=joint angle, 2=joint offset, 3=link lenght, 4=twist angle
T01=DHmatrix(j(1,1),j(2,1),j(3,1),j(4,1));
T12=DHmatrix(j(1,2),j(2,2),j(3,2),j(4,2));
T23=DHmatrix(j(1,3),j(2,3),j(3,3),j(4,3));
T34=DHmatrix(j(1,4),j(2,4),j(3,4),j(4,4));

T02=T01*T12;
T03=T02*T23;
T04=T03*T34;
FK=[T01 T02 T03 T04];
%FK=[T01 T02 T03 T04;T01 T12 T23 T34];
end

DHkine(j);