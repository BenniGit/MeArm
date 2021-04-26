function [x,y] = polar2cart(r,theta)
%POLAR2CART
%INPUT:
%r = radius 
%theta = angle in radian
%OUTPUT:
%x = length of x
%y = length of y

x = r*cos(theta);
y = r*sin(theta);

if abs(x) < 10^-10
    x = 0;
end
if abs(y) < 10^-10
    y = 0;
end


