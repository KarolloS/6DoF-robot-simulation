function [] = setAngle(Id,angle)
%Id - numer serwa
%angle - kat w stopniach
global velocity
velocity = 80;
    if Id == 0
        Id0(angle)
    elseif Id == 1
        Id1(angle)
    elseif Id == 3
        Id3(angle)
    elseif Id == 5
        Id5(angle)
    elseif Id == 6
        Id6(angle)
    end
end

function [] = Id0(angle)
global velocity
GoalPos=2030+angle/0.088;
calllib('dynamixel', 'dxl_write_word',0,32,velocity);
calllib('dynamixel','dxl_write_word',0,30,GoalPos);
end

function [] = Id1(angle)
global velocity
GoalPos=2048+angle/0.088;
calllib('dynamixel', 'dxl_write_word',1,32,velocity);
calllib('dynamixel','dxl_write_word',1,30,GoalPos);
end

function [] = Id3(angle)
global velocity
GoalPos=2048-angle/0.088;
calllib('dynamixel', 'dxl_write_word',3,32,velocity);
calllib('dynamixel','dxl_write_word',3,30,GoalPos);
end


function [] = Id5(angle)
global velocity
GoalPos=2048-angle/0.086;
calllib('dynamixel', 'dxl_write_word',5,32,velocity);
calllib('dynamixel','dxl_write_word',5,30,GoalPos);
end

function [] = Id6(angle)
global velocity
GoalPos=2048-angle/0.086;
calllib('dynamixel', 'dxl_write_word',6,32,velocity);
calllib('dynamixel','dxl_write_word',6,30,GoalPos);
end