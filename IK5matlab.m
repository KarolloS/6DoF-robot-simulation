function IK5matlab()
    clear; clc;
    openGripper();
    global target;
    fun = @rownania;
    l = 18; %liczba ruchów
    fi0 = [0.001, 0.001, 0.001, 0, 0.001, 0.001]';
%    target_table = [9, -15, 7, pi/2, pi, -pi/2]';
    target_table = swap([17.5, 16], [0, -20], [17.5, -13]);
     % ustaw k¹ty pocz¹tkowe
     setManipulator([0 0 0 0 0 0]);
     openGripper;
     
    % obliczaj kolejne po³o¿enia
    for i = 1:l
        target = target_table(:,i);
        fi = fsolve(fun,fi0); %w radianach
        fi = radtodeg(fi);
        setManipulator(fi); %w stopniach
        
        if (i==2 || i==8 || i==14)
            closeGripper(); 
        end
        if(i==5 || i==11 || i==17)
            openGripper();
        end
    end
    target_table = swap([17.5, 6], [9, -20], [17.5, -13]);
    setManipulator([0 0 0 0 0 0]);
    openGripper;
     
    % obliczaj kolejne po³o¿enia
    for i = 1:l
        target = target_table(:,i);
        fi = fsolve(fun,fi0); %w radianach
        fi = radtodeg(fi);
        setManipulator(fi); %w stopniach
        
        if (i==2 || i==8 || i==14)
            closeGripper(); 
        end
        if(i==5 || i==11 || i==17)
            openGripper();
        end
    end
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

if (R06(3,3)==1)
    Q0 = [W; 0; 0; atan2(R06(2,1), R06(1,1))];
elseif (R06(3,3)==-1)
    Q0 = [W; 0; pi; atan2(R06(2,1), R06(1,1))];
else    
    if(isreal(R06(1,3)) && isreal(sin(acos(R06(3,3)))) && isreal(R06(3,1)))
        Q0 = [W; atan2(R06(1,3)/(sin(acos(R06(3,3)))),-R06(2,3)/(sin(acos(R06(3,3)))));  acos(R06(3,3)); atan2(R06(3,1)/(sin(acos(R06(3,3)))), R06(3,2)/(sin(acos(R06(3,3)))))];
    else
        Q0 = [W; 0; pi; atan2(R06(2,1), R06(1,1))];
    end
end
Q=Q0-target;
end
