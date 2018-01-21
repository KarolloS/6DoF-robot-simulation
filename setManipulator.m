function [  ] = setManipulator( q )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
global COMM_RXSUCCESS
COMM_RXSUCCESS     = 1;
moving = [ 1 1 1 1 1];

setAngle(0,q(1));
setAngle(1,q(2));
setAngle(3,q(3));
setAngle(5,q(5));
setAngle(6,q(6));

while ~isequal(moving, [0 0 0 0 0])
    
    CommStatus = int32(calllib('dynamixel','dxl_get_result'));
    if CommStatus == COMM_RXSUCCESS
        PrintErrorCode();
    else
        PrintCommStatus(CommStatus);
        break;
    end
    moving(1) = int32(calllib('dynamixel','dxl_read_byte',0,46));
    moving(2) = int32(calllib('dynamixel','dxl_read_byte',1,46));
    moving(3) = int32(calllib('dynamixel','dxl_read_byte',3,46));
    moving(4) = int32(calllib('dynamixel','dxl_read_byte',5,46));
    moving(5) = int32(calllib('dynamixel','dxl_read_byte',6,46));
end
disp('Moving done');
end
%Print commuication result
function [] = PrintErrorCode()
global ERRBIT_VOLTAGE
global ERRBIT_ANGLE 
global ERRBIT_OVERHEAT
global ERRBIT_RANGE
global ERRBIT_CHECKSUM
global ERRBIT_OVERLOAD
global ERRBIT_INSTRUCTION


 if int32(calllib('dynamixel','dxl_get_rxpacket_error', ERRBIT_VOLTAGE))==1
     disp('Input Voltage Error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_ANGLE))==1
     disp('Angle limit error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_OVERHEAT))==1
     disp('Overheat error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_RANGE))==1
     disp('Out of range error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_CHECKSUM))==1
     disp('Checksum error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_OVERLOAD))==1
     disp('Overload error!');
 elseif int32(calllib('dynamixel','dxl_get_rxpacket_error',ERRBIT_INSTRUCTION))==1
     disp('Instruction code error!');
 end
end
 % Print error bit of status packet
 function [] = PrintCommStatus( CommStatus )

global COMM_TXFAIL
global COMM_RXFAIL
global COMM_TXERROR
global COMM_RXWAITING
global COMM_RXTIMEOUT
global COMM_RXCORRUPT

switch(CommStatus)
    case COMM_TXFAIL
        disp('COMM_TXFAIL : Failed transmit instruction packet!');
    case COMM_TXERROR
        disp('COMM_TXERROR: Incorrect instruction packet!');
    case COMM_RXFAIL
        disp('COMM_RXFAIL: Failed get status packet from device!');
    case COMM_RXWAITING
        disp('COMM_RXWAITING: Now recieving status packet!');
    case COMM_RXTIMEOUT
        disp('COMM_RXTIMEOUT: There is no status packet!');
    case COMM_RXCORRUPT
        disp('COMM_RXCORRUPT: Incorrect status packet!');
    otherwise
        disp('This is unknown error code!');
  
end
 end
    