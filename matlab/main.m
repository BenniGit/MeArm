%% main
clear all port
clc
close all

arm = MeArm('D3','D5','D6','D9');


arm.openGripper();
pause(3);
arm.closeGripper();
pause(3);

