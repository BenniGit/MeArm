%% main
clear all port
clc
close all

arm = MeArm('D3','D5','D6','D9');

  arm.closeGripper(0);
  fprintf('0 \n');
  pause(1);
  arm.closeGripper(0.1);
  fprintf('0.1 \n');
  pause(1);
  arm.closeGripper(0.2);
  fprintf('0.2 \n');
  pause(1);
  arm.closeGripper(0.3);
  fprintf('0.3 \n');
  pause(1);
  arm.closeGripper(0.4);
  fprintf('0.4 \n');
  pause(1);
  arm.closeGripper(0.5);
  fprintf('0.5 \n');
  pause(1);
  arm.closeGripper(0.6);
  fprintf('0.6 \n');
  pause(1);
  arm.closeGripper(0.7);
  fprintf('0.7 \n');
  pause(1);
  arm.closeGripper(0.8);
  fprintf('0.8 \n');
  pause(1);
  arm.closeGripper(0.9);
  fprintf('0.9 \n');
  pause(1);
  arm.closeGripper(1);
  fprintf('1 \n');
  pause(1);
%   arm.openGripper();
%   arm.closeGripper();
%   arm.openGripper();
%   pause(0.5);
%   %%Go up and left to grab something
%   arm.goToPoint(-80,100,140); 
%   arm.closeGripper();
%   %%Go down, forward and right to drop it
%   arm.goToPoint(70,200,10);
%   arm.openGripper();
%   %%Back to start position
%   arm.goToPoint(0,100,50);
%   pause(0.5);
  
% s = Servo();
% s.move(0.9);
% pause(1);
% s.move(0.4);
