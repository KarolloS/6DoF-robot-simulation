function pos = getAngle(Id)
%Id - numer serwa
% - kat w stopniach
    if Id == 0
        pos = int32(calllib('dynamixel','dxl_read_word',0,36));
    elseif Id == 1
        pos = int32(calllib('dynamixel','dxl_read_word',1,36));
    elseif Id == 3
        pos = int32(calllib('dynamixel','dxl_read_word',3,36));
    elseif Id == 5
        pos = int32(calllib('dynamixel','dxl_read_word',5,36));
    elseif Id == 6
        pos = int32(calllib('dynamixel','dxl_read_word',6,36));
    end
end