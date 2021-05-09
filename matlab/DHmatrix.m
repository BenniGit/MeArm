function [Mdh] = DHmatrix(theta,d,a,alpha)
% DH matrix
% INPUT:
% theta = rotation of z
% d = translation of z
% a = translation of x
% alpha = rotation of x
% 
% Calculates the Transformation with the parameters

Mdh=[cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);
     sin(theta) cos(theta)*cos(alpha)  -cos(theta)*sin(alpha) a*sin(theta);
     0,sin(alpha),cos(alpha),d;
     0,0,0,1];
end