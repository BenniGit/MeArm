% device = mididevice('INPUT','MPKmini2');
% midi = midireceive(device,4)
% 
% [controlNumber1,~] = midiid;
% pause(1);
% [controlNumber2,~] = midiid;
% pause(1);
% [controlNumber3,~] = midiid;
% pause(1);
% [controlNumber4,~] = midiid;
% 
% controlNumbers = [controlNumber1,controlNumber3;...
%                   controlNumber2,controlNumber4]
              
controlNumbers = [1001,1002,1003,1024]
              
              
initialValue = 0.5;
midicontrolsObject = midicontrols(controlNumbers,initialValue);
while 1
midiread(midicontrolsObject)
end


