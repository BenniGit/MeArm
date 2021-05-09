function [r,theta] = cart2polar(x,y)
% CART2POLAR
% INPUT:
% [a,b] = cartesian coordinates
% OUTPUT:
% [r,theta] = polar coordinates
% 
% Calculates the the values of radius and theta in the 2D plane with the
% inputs x and y
theta = atan2(y,x);
r = hypot(x,y);
end
