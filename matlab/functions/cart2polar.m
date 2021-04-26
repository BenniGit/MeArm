function [r,theta] = cart2polar(x,y)
%CART2POLAR
%INPUT:
%[a,b] = cartesian coordinates
%OUTPUT:
%[r,theta] = polar coordinates

theta = atan2(y,x);
r = hypot(x,y);
end
