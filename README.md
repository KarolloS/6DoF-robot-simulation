# 6DoF-robot-simulation

Simulation of a manipulator with 6 degrees of freedom in virtual robot experimentation platform [V-Rep](http://www.coppeliarobotics.com/index.html)
and MatLab. The main goal of this project was evaluation of self derived, analytical solution of inverse kinematics before 
implementation in real robot.

Simulation was based on client-server architecture. Server (V-Rep) receives command signal, performs movement,
and sends actual position to client. Based on the actual position of the robot, MatLab script (client) 
calculates next command signal (desired angular position of all the joints in the robot) and sends it back to the server.

V-Rep model contains visual layer based on the CAD (left image) and simplified physical layer (right image).

![alt text](https://github.com/KarolloS/5DoF-robot-simulation/blob/master/V-Rep%20model.png)

Client-Server communication was based on the [Remote-API](http://www.coppeliarobotics.com/helpFiles/en/remoteApiClientSide.htm) provided by Coppelia Robotics.

More about V-Rep software [here](http://www.coppeliarobotics.com/helpFiles/index.html).

Project was done as a part of Group Project at Warsaw University of Technology.

