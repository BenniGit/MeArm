%%% testing all joints
%% main
clear all port
clc
close all

port='COM5';
board='Uno';          
a = arduino(port, board,'libraries','servo');

gripper = Servo('D9', a);
shoulder = Servo('D6', a);
elbow = Servo('D5', a);
base = Servo('D4', a);

%% starting position
shoulder.move(0.7);
elbow.move(0.7);
base.move(1);


%% test gripper - working
gripper.move(0.5); %open
fprintf('gripper open \n');
pause(1);
gripper.move(0.1); %close
fprintf('gripper closed \n');
pause(1);

% test shoulder -working
gripper.move(0.5); % open
fprintf('gripper open \n');
shoulder.move(0.8); %down
fprintf('shoulder down and wait \n');
pause(5); % wait
gripper.move(0.1); % close
fprintf('gripper closed and wait\n');
pause(5);
%slowly up
for angle = 1:-0.05:0
    shoulder.move(angle); %open
    
    if (angle+0.5)>1
        angleelbow = 1;
    else
        algleelbow = angle + 0.5;
    end
    elbow.move(angleelbow);
    fprintf('shoulder: %f \n', angle);
    fprintf('up \n');
    pause(1);
end

%slowly down
for angle = 1:0.05:0
    shoulder.move(angle); %open
    fprintf('shoulder: %f \n', angle);
    fprintf('down \n');
    pause(1);
end
gripper.move(0.5); % open
fprintf('gripper closed \n');

% elbow test
shoulder.move(0.5); %up
fprintf('shoulder up \n');
for angle = 0.6:0.05:1 % vorwärts/auf
    elbow.move(angle); 
    fprintf(' elbow : %f \n', angle);
    pause(1);
end

shoulder.move(0.8); %down
fprintf('shoulder down \n');
for angle = 0.8:-0.05:0.5 % rückwärt/zu
    elbow.move(angle);
    fprintf('elbow: %f \n', angle);
    pause(1);
end

% base-test
shoulder.move(0.5); % up
fprintf('shoulder up \n');
elbow.move(0.8); % up
fprintf('elbow up \n');
for angle = 1:-0.05:0
    base.move(angle); %open
    fprintf('base: %f \n', angle);
    pause(1);
end