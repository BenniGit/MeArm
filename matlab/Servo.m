classdef Servo
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        minPulse = 5.44e-04;
        maxPulse = 2.40e-03;
        servo;
    end
    
    methods
        function obj = Servo()
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            port='COM5';
            board='Uno';
            a = arduino(port, board,'libraries','servo');
            pin = 'D9';
            obj.servo = servo(a, pin, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
        end
        
        function move(obj, position)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            writePosition(obj.servo, position);
            fprintf('moved');
        end
    end
end

