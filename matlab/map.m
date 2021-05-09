function y = map(x,in_min,in_max,out_min,out_max)
% Map function
% INPUT:
% x = variable to map
% in_min = the minimum of x
% in_max = the maximum of x
% out_min = the minimum of y
% out_max = the maximum of y
% OUTPUT:
% y = changed range of x
% 
% This function maps a Value in certain range to another range.
% For example from 0 to pi --> 0 to 1

            if x<in_min
                x = in_min;
            end
            if x>in_max
                x = in_max;
            end
            y = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end