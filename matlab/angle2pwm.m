function pwm = angle2pwm(angle, gain, zero)
%ANGLE2PWM Summary of this function goes here
%   Detailed explanation goes here
pwm = 0.5 +zero+gain*angle;

end

