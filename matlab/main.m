%% main
clear all port
clc
close all

arm = MeArm('D3','D5','D6','D9');

%   arm.openGripper();
%   arm.closeGripper();
%   arm.openGripper();
%   arm.closeGripper();

  pause(0.5);
  %%Go up and left to grab something
  arm.goDirectlyTo(120,0,10); 
  %arm.goToPoint(120,0,10); 
  pause(0.5);
  %arm.closeGripper();
  arm.goDirectlyTo(100,0,80);
  %%Go down, forward and right to drop it
  %arm.goToPoint(120,pi/2,10);

  %arm.openGripper();
  %%Back to start position
  %arm.goToPoint(100,0,50);
  pause(0.5);

