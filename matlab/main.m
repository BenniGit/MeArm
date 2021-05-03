%% main
clear all port
clc
close all

arm = MeArm('D4','D5','D6','D9');
[r, phi, z] = arm.get_position(0,0, pi/4)
% pause(1);
% arm.goToPoint(60,pi,80);
% 
% arm.goDirectlyTo(40,0,30);
% pause(1);
% [r,phi,z] = arm.read_position()
% pause(1);
% for i = 1:10
arm.goDirectlyTo(80,pi/2,50);
%     [r,phi,z] = arm.read_position()
%     pause(1);
% end
% pause(2);
% [r, phi, z] = arm.get_position(pi/4,0, 0);
% arm.goDirectlyTo(r,phi,z);
% pause(2);
% [r, phi, z] = arm.get_position(0, pi/4,0);
% arm.goDirectlyTo(r,phi,z);
[r, phi, z] = arm.get_position(pi/4,pi/4,pi/4);
arm.goDirectlyTo(r,phi,z);
for i = 0:4
    pause(1);
    fprintf('moving ellbow \n')
    [r, phi, z] = arm.get_position(pi/4,pi/4,i*pi/16)
    
    [r, phi, z] = arm.read_position()
end
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
  

