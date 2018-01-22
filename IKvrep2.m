function IKvrep()
    clc;
    disp('Program started');
    vrep=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)
    vrep.simxFinish(-1); % just in case, close all opened connections
    clientID=vrep.simxStart('127.0.0.1',19997,true,true,5000,5);

    if (clientID>-1)
        disp('Connected to remote API server');

		% enable the synchronous mode on the client:
		vrep.simxSynchronous(clientID,true);

		% start the simulation:
		vrep.simxStartSimulation(clientID,vrep.simx_opmode_blocking);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        [~,joint1]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_1',vrep.simx_opmode_blocking);
        [~,joint2]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_2',vrep.simx_opmode_blocking);
        [~,joint3]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_3',vrep.simx_opmode_blocking);
        [~,joint4]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_4',vrep.simx_opmode_blocking);
        [~,joint5]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_5',vrep.simx_opmode_blocking);
        [~,joint6]=vrep.simxGetObjectHandle(clientID,'Revolute_joint_6',vrep.simx_opmode_blocking);

        vrep.simxSynchronousTrigger(clientID);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            

        [~,~] = vrep.simxGetJointPosition(clientID, joint1, vrep.simx_opmode_streaming);
        [~,~] = vrep.simxGetJointPosition(clientID, joint2, vrep.simx_opmode_streaming);
        [~,~] = vrep.simxGetJointPosition(clientID, joint3, vrep.simx_opmode_streaming);
        [~,~] = vrep.simxGetJointPosition(clientID, joint4, vrep.simx_opmode_streaming);
        [~,~] = vrep.simxGetJointPosition(clientID, joint5, vrep.simx_opmode_streaming);
        [~,~] = vrep.simxGetJointPosition(clientID, joint6, vrep.simx_opmode_streaming);
        
%         [~,fi(1)] = vrep.simxGetJointPosition(clientID, joint1, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);
%         [~,fi(2)] = vrep.simxGetJointPosition(clientID, joint2, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);
%         [~,fi(3)] = vrep.simxGetJointPosition(clientID, joint3, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);
%         [~,0] = vrep.simxGetJointPosition(clientID, joint4, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);
%         [~,fi(5)] = vrep.simxGetJointPosition(clientID, joint5, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);
%         [~,fi(6)] = vrep.simxGetJointPosition(clientID, joint6, vrep.simx_opmode_blocking);
%         vrep.simxSynchronousTrigger(clientID);

        % ustawienie pocz¹tkowych k¹tów na 0
        for j = [1:10]
            [~] = vrep.simxSetJointTargetPosition(clientID,joint1, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint2, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint3, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint4, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint5, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint6, 0, vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
        global target;
        fun = @rownania;
        fi0 = [0.001, 0.001, 0.001, 0, 0.001, 0.001]';        
        target_table = [20, 0, 15, pi/2, pi, -pi/2;...
            0, 20, 15, pi/2, pi, -pi/2]'
        
        l = 2; %liczba ruchów
        for i = [1:l]
            target = target_table(:,i);
            i
            fi = fsolve(fun,fi0)
            
            % ustaw k¹ty na serwach
            [~] = vrep.simxSetJointTargetPosition(clientID,joint1, fi(1), vrep.simx_opmode_streaming);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint2, fi(2), vrep.simx_opmode_streaming);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint3, fi(3), vrep.simx_opmode_streaming);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint4, fi(4), vrep.simx_opmode_streaming);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint5, fi(5), vrep.simx_opmode_streaming);
            [~] = vrep.simxSetJointTargetPosition(clientID,joint6, fi(6), vrep.simx_opmode_streaming);
            vrep.simxSynchronousTrigger(clientID);
            
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Before closing the connection to V-REP, make sure that the last command sent out had time to arrive:
        vrep.simxGetPingTime(clientID);

        % stop the simulation:
		vrep.simxStopSimulation(clientID,vrep.simx_opmode_blocking);
        
        % Now close the connection to V-REP:
        vrep.simxFinish(clientID);
    else
        disp('Failed connecting to remote API server');
    end
    
    vrep.delete(); % call the destructor!
    disp('Program ended');
end

function Q = rownania(fi)
global target;
a=11; b=14; c=6.3; d=6.3; e=3.3; z=8.5;

W = [cos(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) + sin(fi(1))*sin(0)*(d + cos(fi(5))*(e + z));
 sin(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) - cos(fi(1))*sin(0)*(d + cos(fi(5))*(e + z));
                                                   a - sin(fi(2))*(sin(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + cos(fi(2))*(b + cos(fi(3))*(c + cos(0)*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))];
R06 = [ cos(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(0) + cos(0)*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - sin(fi(6))*(cos(0)*sin(fi(1)) - sin(0)*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), - sin(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(0) + cos(0)*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - cos(fi(6))*(cos(0)*sin(fi(1)) - sin(0)*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), sin(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) + cos(fi(5))*(sin(fi(1))*sin(0) + cos(0)*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))));
cos(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(0) - cos(0)*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))) + sin(fi(6))*(sin(0)*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(0)),   cos(fi(6))*(sin(0)*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(0)) - sin(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(0) - cos(0)*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))), sin(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) - cos(fi(5))*(cos(fi(1))*sin(0) - cos(0)*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))));
                                                                                                - cos(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(0)*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - sin(0)*sin(fi(6))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                                                                     sin(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(0)*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - cos(fi(6))*sin(0)*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                         - sin(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(0)*cos(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))];

if (acos(R06(3,3))==0)
    Q0 = [W; 0; 0; atan2(R06(2,1), R06(1,1))];
elseif (acos(R06(3,3))==pi)
    Q0 = [W; 0; pi; atan2(R06(2,1), R06(1,1))];
else
    Q0 = [W; atan2(R06(1,3)/(sin(acos(R06(3,3)))),-R06(2,3)/(sin(acos(R06(3,3)))));  acos(R06(3,3)); atan2(R06(3,1)/(sin(acos(R06(3,3)))), R06(3,2)/(sin(acos(R06(3,3)))))];
end

Q=Q0-target;
end
