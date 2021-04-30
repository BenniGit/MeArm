function val = angle2val(angle)
%ANGLE2VAL

val = angle/pi;
val = abs(val);
fprintf('angle: %d \n', val);
end

