classdef MeArm
    %MEARM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        minPulse = 5.44e-04;
        maxPulse = 2.40e-03;
        base
        shoulder
        elbow
        gripper
        x
        y
        z
        base_gain
        base_zero
        shoulder_gain
        shoulder_zero
        elbow_gain
        elbow_zero
%         %% Base
%         sweepMinBase=145;
%         sweepMaxBase=49;
%         angleMinBase=-pi/4;
%         angleMaxBase=pi/4;
%         %% Shoulder
%         sweepMinShoulder=118;
%         sweepMaxShoulder=22;
%         angleMinShoulder=pi/4;
%         angleMaxShoulder=3*pi/4;
%         %% Elbow
%         sweepMinElbow=144;
%         sweepMaxElbow=36;
%         angleMinElbow=pi/4;
%         angleMaxElbow=-pi/4;
%         %% Gripper
%         sweepMinGripper=75;
%         sweepMaxGripper=115;
%         angleMinGripper=pi/2;
%         angleMaxGripper=0;
    end
    
    methods
        function obj = MeArm(pinBase, pinShoulder, pinElbow, pinGripper)
            %MEARM Construct an instance of this class
            %   Detailed explanation goes here
            %create the arduino and servo objects in matlab
            port='COM5';
            board='Uno';
            a = arduino(port, board,'libraries','servo');
            obj.base = servo(a, pinBase, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.shoulder = servo(a, pinShoulder, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.elbow = servo(a, pinElbow, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.gripper = servo(a, pinGripper, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
%             %% get gain and zero 
%             obj.base_gain, obj.base_zero = get_gain_and_zero(obj.sweepMinBase, obj.sweepMaxBase, obj.angleMinBase, obj.angleMaxBase);
%             obj.shoulder_gain, obj.shoulder_zero = get_gain_and_zero(obj.sweepMinShoulder, obj.sweepMaxShoulder, obj.angleMinShoulder, obj.angleMaxShoulder);
%             obj.elbow_gain, obj.elbow_zero = get_gain_and_zero(obj.sweepMinElbow, obj.sweepMaxElbow, obj.angleMinElbow, obj.angleMaxElbow);
            %% first move
            obj.goDirectlyTo(0, 100, 50);
            obj.openGripper();
        end
        
        function move = goDirectlyTo(obj,x, y, z)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            move = 1;
            obj.x = x;
            obj.y = y;
            obj.z = z;
            [is_reachable, radBase, radShoulder, radElbow] = solve(x,y,z);
            if is_reachable
%                 writePosition(obj.base, angle2pwm(radBase, obj.base_gain, obj.base_zero))
%                 writePosition(obj.shoulder, angle2pwm(radShoulder, obj.shoulder_gain, obj.shoulder_zero))
%                 writePosition(obj.elbow, angle2pwm(radElbow,obj.elbow_gain, obj.elbow_zero))
                
                writePosition(obj.base, angle2val(radBase))
                writePosition(obj.shoulder, angle2val(radShoulder))
                writePosition(obj.elbow, angle2val(radElbow))
                pause(0.05)
            else
                move = 0;
            end
        end
        
        function goToPoint(obj,x, y, z)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            dist = sqrt((obj.x-x)*(obj.x-x)+(obj.y-y)*(obj.y-y)+(obj.z-z)*(obj.y-z));
            step = 10;
            for i = 0:step:dist
                obj.goDirectlyTo(obj.x + (x-obj.x)*i/dist, obj.y + (y-obj.y) * i/dist, obj.z + (z-obj.x) * i/dist)
            end
            obj.goDirectlyTo(x, y, z)
            % check position
            current_pos_base = readPosition(obj.base);
            fprintf('position_base: %d \n', current_pos_base);
            current_pos_shoulder = readPosition(obj.shoulder);
            fprintf('position_shoulder: %d \n', current_pos_shoulder);
            current_pos_elbow = readPosition(obj.elbow);
            fprintf('position_elbow: %d \n', current_pos_elbow);
            current_pos_gripper = readPosition(obj.gripper);
            fprintf('position_gripper: %d \n', current_pos_gripper);
        end
        
        function closeGripper(obj)
            writePosition(obj.gripper, 0.1);
            pause(0.3);
        end
        
        function openGripper(obj)
            writePosition(obj.gripper,0.5);
                        pause(0.3);
        end
    end
end

