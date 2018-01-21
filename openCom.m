global ERRBIT_VOLTAGE
ERRBIT_VOLTAGE     = 1;
global ERRBIT_ANGLE 
ERRBIT_ANGLE       = 2;
global ERRBIT_OVERHEAT
ERRBIT_OVERHEAT    = 4;
global ERRBIT_RANGE
ERRBIT_RANGE       = 8;
global ERRBIT_CHECKSUM
ERRBIT_CHECKSUM    = 16;
global ERRBIT_OVERLOAD
ERRBIT_OVERLOAD    = 32;
global ERRBIT_INSTRUCTION
ERRBIT_INSTRUCTION = 64;

global COMM_TXSUCCESS
COMM_TXSUCCESS     = 0;
global COMM_RXSUCCESS
COMM_RXSUCCESS     = 1;
global COMM_TXFAIL
COMM_TXFAIL        = 2;
global COMM_RXFAIL
COMM_RXFAIL        = 3;
global COMM_TXERROR
COMM_TXERROR       = 4;
global COMM_RXWAITING
COMM_RXWAITING     = 5;
global COMM_RXTIMEOUT
COMM_RXTIMEOUT     = 6;
global COMM_RXCORRUPT
COMM_RXCORRUPT     = 7;


loadlibrary('dynamixel','dxl_matlab.h');
libfunctions('dynamixel');

%Default Setting
id = 1; % dynamixel id
P_GOAL_POSITION = 30;
P_PRESENT_POSITION = 36;
DEFAULT_PORTNUM = 5; % com5
DEFAULT_BAUDNUM = 1; % 1mbps
P_Moving = 46;

int32 GoalPos;
GoalPos = [0 1023];
%GoalPos = [0 4095] %for Ex Series
int32 index;
index = 4;
int32 PresentPos;
int32 Moving;
int32 CommStatus;

%open device
res = calllib('dynamixel','dxl_initialize',DEFAULT_PORTNUM,DEFAULT_BAUDNUM);
if res == 1
    disp('Succeed to open USB2Dynamixel!');
else
    disp('Connection failed!');
end