%% main
clear all port
clc
close all

arm = MeArm('D4','D5','D6','D9');
[r, phi, z] = arm.get_position(pi/4, 0, 0)

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
  

