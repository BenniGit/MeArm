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
        r
        phi
        z
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
            %% first move
            obj.goDirectlyTo(100, 0, 50);
            obj.openGripper();
        end
        
        function move = goDirectlyTo(obj,r, phi, z)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            move = 1;
            obj.r = r;
            obj.phi = phi;
            obj.z = z;
            [is_reachable, radBase, radShoulder, radElbow] = solve(r,phi,z);
            if is_reachable
%                 writePosition(obj.base, angle2pwm(radBase, obj.base_gain, obj.base_zero))
%                 writePosition(obj.shoulder, angle2pwm(radShoulder, obj.shoulder_gain, obj.shoulder_zero))
%                 writePosition(obj.elbow, angle2pwm(radElbow,obj.elbow_gain, obj.elbow_zero))
                fprintf('radbase: %d \n', radBase);
                fprintf('radShoulder: %d \n', radShoulder);
                fprintf('radElbow: %d \n', radElbow);
                writePosition(obj.base, angle2val(radBase))
                fprintf('Value_base: %d \n', angle2val(radBase));
                writePosition(obj.shoulder, 0.5+angle2val(radShoulder))
                fprintf('Value_Shoulder: %d \n', angle2val(radShoulder));
                writePosition(obj.elbow, 0.5+angle2val(radElbow))
                fprintf('Value_Elbow: %d \n', angle2val(radElbow));
                pause(0.05)
            else
                move = 0;
                fprintf('out of reach \n');
            end
        end
        
        function goToPoint(obj,r, phi, z)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            r0 = obj.r;
            phi0 = obj.phi;
            z0 = obj.z;
            step = 10;
            distr = (r0-r)/step;
            distphi = (phi0-phi)/step;
            distz = (z0-z)/step;
            step = 10;
            for i = 0:step
                obj.goDirectlyTo(r0 + i*distr, phi0 + i*distphi, z0 + i*distz)
            end
            obj.goDirectlyTo(r, phi, z)
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

