function y = map(x,in_min,in_max,out_min,out_max)
            if x<in_min
                x = in_min;
            end
            if x>in_max
                x = in_max;
            end
            y = (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
end