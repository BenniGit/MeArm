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
        r = 50;
        phi = pi/2;
        z = 40;
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
            obj.goToPoint(50, pi/2, 40);
            %obj.openGripper();
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
                writePosition(obj.base, angle2val(radBase))
                fprintf('Value_base: %d \n', angle2val(radBase));
                writePosition(obj.shoulder, 0.5+angle2val(radShoulder))
                writePosition(obj.elbow, 0.5+angle2val(radElbow))
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
            step = 20;
            distr = (r-r0)/step;
            distphi = (phi-phi0)/step;
            distz = (z-z0)/step;
            fprintf('r0 = %d \n',r0);
            fprintf('with a distr = %d \n',distr);
            fprintf('phi0 = %d',phi0);
            fprintf('with a distphi = %d \n',distphi);
            fprintf('z0 = %d',z0);
            fprintf('with a distz = %d \n',distz);
            for i = 1:step
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
        
        function [r, phi, z] = get_position(obj, j1, j2, j3)
            j = [j1 j2 j3 0;0 0 0 0;0 80 80 68; pi/2 0 0 0];
            fprintf(' anfangsradius:');
            FK = DHkine(j);
            obj.r
            [x0,y0] = polar2cart(obj.r,obj.phi);
            Q = FK*[x0; y0; obj.z;1];
            x = Q(1);
            y = Q(2);
            z = Q(3);
            [r,phi] = cart2polar(x,y);
        end
    end
end

