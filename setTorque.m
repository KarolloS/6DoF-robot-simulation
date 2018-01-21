function []=setTorque(mode)
for i=[0:6]
    if(i==4) continue; end
    calllib('dynamixel','dxl_write_word',i,24,mode);
end
end