function val = angle2val(angle)
% ANGLE2VAL
% INPUT:
% angle = angles from 0 to pi
% OUTPUT:
% val = value from 0 to 1
val = angle/pi;
% Just for security reasons we decided to take the absolute value of  the
% value
val = abs(val);
%fprintf('angle: %d \n', val);
end

