function [bool,theta] = cosangle(opp,adj1,adj2)
%COSANGLE 
% INPUT:
% opp = c
% adj1 = a
% adj2 = b
% OUTPUT:
% bool =  0 angle can not be calculated
%         1 angle calculated
% theta = angle

bool = 1;
% Cosine rule:
% C^2 = A^2 + B^2 - 2*A*B*cos(angle_AB)
% cos(angle_AB) = (A^2 + B^2 - C^2)/(2*A*B)
% C is opposite
% A, B are adjacent

den = 2*adj1*adj2;

if (den == 0)
    bool = 0;
end

c = (adj1^2 + adj2^2 - opp^2)/den;

if(abs(c)>1) 
    bool = 0;
end

if (bool == 0)
    theta = 0;
else
    theta = acos(c);
end