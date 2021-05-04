classdef MeArm
    %MEARM Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        minPulse = 5.44e-04;
        maxPulse = 2.40e-03;
        a;
        base;
        shoulder;
        elbow;
        gripper;
        ultrasonic;
        r;
        phi;
        z;
    end
    
    methods
        function obj = MeArm(pinBase, pinShoulder, pinElbow, pinGripper)
            %MEARM Construct an instance of this class
            %   Detailed explanation goes here
            %create the arduino and servo objects in matlab
            port='COM5';
            board='Uno';
            obj.a = arduino(port, board,'libraries',{'servo','Ultrasonic'});
            obj.ultrasonic = ultrasonic(obj.a,'D12','D13');
            obj.base = servo(obj.a, pinBase, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.shoulder = servo(obj.a, pinShoulder, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.elbow = servo(obj.a, pinElbow, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.gripper = servo(obj.a, pinGripper, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.r = 50;
            obj.phi = pi;
            obj.z = 40;
            %% first move
            %obj.goToPoint(50, pi/2, 40);
            %obj.openGripper();
        end
        function value = readDistance(obj)
            distance = readDistance(obj.ultrasonic);
            if distance > 0.5
                distance = 0.5;
            end
            value = distance / 0.5;
            
        end
        
        function bool = readButton(obj)
            bool = readDigitalPin(obj.a,'D11');
        end
        
        function value = readPoti(obj)
            value = readVoltage(obj.a,'A1');
            value = map(value,0.2,4.8,0,1);
        end
        
        
        function move = goDirectlyTo(obj,r, phi, z)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            move = 1;
%             obj.r = r;
%             obj.phi = phi;
%             obj.z = z;
            [is_reachable, radBase, radShoulder, radElbow] = solve(r,phi,z);
            if is_reachable
%                 writePosition(obj.base, angle2pwm(radBase, obj.base_gain, obj.base_zero))
%                 writePosition(obj.shoulder, angle2pwm(radShoulder, obj.shoulder_gain, obj.shoulder_zero))
%                 writePosition(obj.elbow, angle2pwm(radElbow,obj.elbow_gain, obj.elbow_zero))
                %fprintf('radbase: %d \n', radBase);
                writePosition(obj.base, angle2val(radBase))
                %fprintf('Value_base: %d \n', angle2val(radBase));
                writePosition(obj.shoulder, angle2val(radShoulder))
                fprintf('Value_Shoulder: %d \n', angle2val(radShoulder));
                writePosition(obj.elbow, angle2val(radElbow))
                pause(0.05)
                [r_1,phi_1,z_1] = obj.read_position();
                obj.set_r(r_1);
                obj.set_phi(phi_1);
                obj.set_z(z_1);
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
            
            % check position
            %current_pos_base = readPosition(obj.base);
            %fprintf('position_base: %d \n', current_pos_base);
            %current_pos_shoulder = readPosition(obj.shoulder);
            %fprintf('position_shoulder: %d \n', current_pos_shoulder);
            %current_pos_elbow = readPosition(obj.elbow);
            %fprintf('position_elbow: %d \n', current_pos_elbow);
            %current_pos_gripper = readPosition(obj.gripper);
            %fprintf('position_gripper: %d \n', current_pos_gripper);
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
%             j = [j1 j2 j3 0;0 0 0 0;0 80 80 68; pi/2 0 0 0];
            if j2>pi   % check if is working (should do the same as correctangles to adjust position of joints to realistic values)
                j2 = pi;
            end
            if j3>pi/2
                j3 = pi/2;
            end
            q1 = j1;
            q2 = j2;
            q3 = pi-j2-j3;
            j = [q1 q2 -(q2+q3) q3;0 0 0 0;0 80 80 68; pi/2 0 0 0];
            FK = DHkine(j);
            Q = FK(:,4);
            x = Q(1);
            y = Q(2);
            z = Q(3);
            [r,phi] = cart2polar(x,y);
            writePosition(obj.base,angle2val(j1));
            writePosition(obj.shoulder,map(j2,0,pi,1,0));
            angle_elbow = pi - j2 -j3;
            if angle_elbow>pi/2
                fprintf('DH angle out of reach');
            else   
            writePosition(obj.elbow,map(angle_elbow,0,pi/2,1,0.5));
            end
        end
        
        function [r,phi,z] = read_position(obj)
            a0 = readPosition(obj.base);
            %fprintf('a0 = %d \n',a0);
            a1 = readPosition(obj.shoulder);
            %fprintf('a1 = %d \n',a1);
            a2 = readPosition(obj.elbow);
            %fprintf('a2 = %d \n',a2);
            [r,phi,z] = unsolve(a0,a1,a2);
        end
        
        function obj = set_r(obj,value)
            obj.r = value;
        end
        function obj = set_phi(obj,value)
            obj.phi = value;
        end
        function obj = set_z(obj,value)
            obj.z = value;
        end
        

    end
end

