function []=setFree(id,mode)
    calllib('dynamixel','dxl_write_word',id,24,mode);
end