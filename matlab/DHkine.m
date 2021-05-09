function [ FK ] = DHkine(j)
% DHkine
% INPUT:
% j = matrix of the DH parameters
% OUTPUT:
% FK = matrix of Forward kinematics
%
% DHkine gets the DH parameters and calculates the Transformation matrix

%collum 1=z angle(rotation of the joint), 2=z length, 3=x lenght, 4=x angle
T01=DHmatrix(j(1,1),j(2,1),j(3,1),j(4,1));
T12=DHmatrix(j(1,2),j(2,2),j(3,2),j(4,2));
T23=DHmatrix(j(1,3),j(2,3),j(3,3),j(4,3));
T34=DHmatrix(j(1,4),j(2,4),j(3,4),j(4,4));
FK = (((T01*T12)*T23)*T34);
end