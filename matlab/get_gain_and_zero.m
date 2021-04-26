function [gain,zero] = get_gain_and_zero(n_min,n_max, a_min, a_max)
%GET_GAIN_AND_ZERO Summary of this function goes here
%   Detailed explanation goes here
n_range = n_max-n_min;
a_range = a_max-a_min;
if a ~= 0
    gain = n_range/a_range;
    zero = n_min - gain*a_min;
end
end

