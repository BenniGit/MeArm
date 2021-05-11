classdef MeArm
    % MEARM
    % This is our MeArm class
    % We have written an extra class for the robot to control him with
    % matlab later objectorientated. In this way we can make sure to set
    % everything variable if we have to change something
%% Properties 
% variables relating to the mearm object
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
%% Methods
% the methods are the main part of the class.
% These methods will be all used later in our main script to control the
% mearm

    methods
        %% Constructor of the MEARM
        function obj = MeArm(pinBase, pinShoulder, pinElbow, pinGripper)
            % Constructor of the MeArm
            % The object will be created here and all things that has to be
            % initialized will be set here
            port='COM5';
            board='Uno';
            obj.a = arduino(port, board,'libraries',{'servo','Ultrasonic'});
            obj.ultrasonic = ultrasonic(obj.a,'D12','D13');
            obj.base = servo(obj.a, pinBase, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.shoulder = servo(obj.a, pinShoulder, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.elbow = servo(obj.a, pinElbow, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            obj.gripper = servo(obj.a, pinGripper, 'MinPulseDuration', obj.minPulse, 'MaxPulseDuration', obj.maxPulse);
            % Start position
            obj.r = 50;
            obj.phi = pi;
            obj.z = 40;
            % first move
            % Gripper should be open in the beginning
            obj.openGripper();
        end
        %% read Distance method
        function value = readDistance(obj)
            % read the Distance of the ultrasonic sensor
            distance = readDistance(obj.ultrasonic);
            % Working range between 0 cm and 20 cm
            if distance > 0.4
                distance = 0.4;
            end
            % Correct the Value to a value from 0 to 1
            value = distance / 0.4;            
        end
        %% read Button method
        function bool = readButton(obj)
            % is the Button pressed 0 or 1
            bool = readDigitalPin(obj.a,'D11');
        end
        %% read Photoresistor method
        function bool = readPhr(obj)
            % is the Button pressed 0 or 1
            value = readVoltage(obj.a,'A0');
            value = map(value,1,3,0,1);
            if value>=0.3
                bool = 1;
            else
                bool = 0;
            end
                    
        end
        %% read Poti method
        function value = readPoti(obj)
            % read the the value of the Poti
            value = readVoltage(obj.a,'A1');
            % transform the the value to a range between 0 and 1
            value = map(value,0.2,4.8,0,1);
        end        
        %% goDirectlyTo method
        function move = goDirectlyTo(obj,r, phi, z)
            % goDirectlyTo method get a certain position r, phi and z. The
            % method will move the the robot to this point if the point is
            % reachable
            move = 1;
            [is_reachable, radBase, radShoulder, radElbow] = solve(r,phi,z);
            % is_reachable is a bool that indicates if the position is
            % reachable for the robot or not. If not he will not go to this
            % value
            if is_reachable
                writePosition(obj.base, angle2val(radBase))
                %fprintf('Value_base: %d \n', angle2val(radBase));
                writePosition(obj.shoulder, angle2val(radShoulder))
                %fprintf('Value_Shoulder: %d \n', angle2val(radShoulder));
                writePosition(obj.elbow, angle2val(radElbow))
                pause(0.05)
                % read the position of the robot and write them into the
                % object variables r, phi and z
                [r_1,phi_1,z_1] = obj.read_position();
                obj.set_r(r_1);
                obj.set_phi(phi_1);
                obj.set_z(z_1);
            else
                % he can not reach the position
                move = 0;
                % print if robot is out of reach
                fprintf('out of reach \n');
            end
        end
        %% goToPoint method
        function goToPoint(obj,r, phi, z)
            % goToPoint
            % Will divide the steps for a certain point in 20 steps and
            % will then slowly move to this point
            r0 = obj.r;
            phi0 = obj.phi;
            z0 = obj.z;
            step = 20;
            distr = (r-r0)/step;
            distphi = (phi-phi0)/step;
            distz = (z-z0)/step;
            for i = 1:step
                obj.goDirectlyTo(r0 + i*distr, phi0 + i*distphi, z0 + i*distz)
            end
        end
        %% close Gripper method
        function closeGripper(obj)
            % closeGripper will close the gripping Joint of the MeArm
            writePosition(obj.gripper, 0.1);
        end
        %% open Gripper method
        function openGripper(obj)
            % closeGripper will open the gripping Joint of the MeArm
            writePosition(obj.gripper,0.5);
        end
        %% get position method
        function [r, phi, z] = get_position(obj, j1, j2, j3)
            % get_position will use the DH parameters.
            % j1 to j3 are the angles between the links
            % the method return the position of the MeArm and also writes
            % the position to the MeArm
            
            % Get the r phi and z values
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
            
            % write the angles of the joints to the Mearm
            writePosition(obj.base,angle2val(j1));
            writePosition(obj.shoulder,map(j2,0,pi,1,0));
            angle_elbow = pi - j2 -j3;
            if angle_elbow>pi/2
                fprintf('DH angle out of reach');
            else   
            writePosition(obj.elbow,map(angle_elbow,0,pi/2,1,0.5));
            end
        end
        %% read_position
        function [r,phi,z] = read_position(obj)
            % read the position of the servos
            a0 = readPosition(obj.base);
            a1 = readPosition(obj.shoulder);
            a2 = readPosition(obj.elbow);
            % the function unsolve get these values to calculate the
            % position in the cylindrical coordinate system
            [r,phi,z] = unsolve(a0,a1,a2);
        end
        
        %% Set the object variables
        % unfortunately you can not set object varibles directly, why we
        % have written these 3 functions
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

