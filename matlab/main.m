%% main
clear all port
clc
close all

% MIDI
controlNumbers = [1001,1002,1003,1024];
initialValue = 0.5;
midicontrolsObject = midicontrols(controlNumbers,initialValue);

%MeArm
arm = MeArm('D4','D6','D5','D9');
potiRadius = 50;
potiPhi = 0;

while 1
midivalues = midiread(midicontrolsObject);
knob1 = midivalues(1);
knob2 = midivalues(2);
% knob3 = midivalues(3);
button = midivalues(4);

% poti = arm.readPoti();
distance = arm.readDistance();
% bool = arm.readButton();
% step = arm.readPhr()
% if step == 0
%     potiRadius = 40+300*poti; 
% else
%     potiPhi = poti*pi;
% end
potiRadius = 40+300*knob2; 
potiPhi = knob1*pi;


arm.goDirectlyTo(potiRadius,potiPhi,-30+110*distance);
    
if button == 1
    arm.closeGripper();
    
else
    arm.openGripper();    
end

end

%[r, phi, z] = arm.get_position(0,0, pi/4)
% pause(1);
% arm.goToPoint(60,pi,80);
% 
% arm.goDirectlyTo(40,0,30);
% pause(1);
% [r,phi,z] = arm.read_position()
% pause(1);
% for i = 1:10
%arm.goDirectlyTo(80,pi/2,50);
%     [r,phi,z] = arm.read_position()
%     pause(1);
% end
% pause(2);
% [r, phi, z] = arm.get_position(pi/4,0, 0);
% arm.goDirectlyTo(r,phi,z);
% pause(2);
% [r, phi, z] = arm.get_position(0, pi/4,0);
% arm.goDirectlyTo(r,phi,z);
% [r, phi, z] = arm.get_position(pi/4,pi/4,pi/4);
% arm.goDirectlyTo(200,pi,50);
% pause(1);
% arm.goDirectlyTo(100,pi/2,40);
% for i = 3:5
%     pause(1);
%     fprintf('DH');
%     
%     [r,phi,z] = arm.get_position(pi,pi/2,i*pi/8)
%     fprintf('Read');
%     [r,phi,z] = arm.read_position()
%     %arm.goToPoint(15*i,0,50);
%     %arm.goDirectlyTo(160,pi,20*i);
%     
%     %[r, phi, z] = arm.read_position()
%     
% end
% for i = 0:4
%     pause(1);
%     [r, phi, z] = arm.get_position(pi/4,i*pi/16,pi/4);
%     fprintf('moving shouldern \n')
%     [r, phi, z] = arm.read_position()
% end
% for i = 0:4
%     pause(1);
%     [r, phi, z] = arm.get_position(i*pi/16,pi/4,pi/4);
%     fprintf('moving base \n')
%     [r, phi, z] = arm.read_position()
% end
%arm.goToPoint(r,phi,z);

%   arm.openGripper();
%   arm.closeGripper();
%   arm.openGripper();
%   arm.closeGripper();

  %pause(0.5);
  %%Go up and left to grab something
  %arm.goToPoint(100,pi,50); 
  %arm.goToPoint(120,0,10); 
  %pause(2);
  %arm.closeGripper();
  %arm.goToPoint(70,pi/2,20);
  %arm.goDirectlyTo(70,pi/2,20);
  %arm.goToPoint(70,pi/2,20);
  %%Go down, forward and right to drop it
  %arm.goToPoint(120,pi/2,10);

  %arm.openGripper();
  %%Back to start position
  %arm.goToPoint(100,0,50);
  

