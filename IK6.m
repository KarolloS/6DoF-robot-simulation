function IK6 ()
clear; clc;
global q;
q = [20, 0, 15, pi/2, pi, -pi/2]';

fun = @rownania;
fi0 = [0.001, 0.001, 0.001, 0, 0.001, 0.001]';
fi = fsolve(fun,fi0)
Q0(fi)

end

function Q0 = Q0(fi)
a=11; b=14; c=6.3; d=6.3; e=3.3; z=8.5;

W = [cos(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) + sin(fi(1))*sin(fi(4))*(d + cos(fi(5))*(e + z));
 sin(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) - cos(fi(1))*sin(fi(4))*(d + cos(fi(5))*(e + z));
                                                   a - sin(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + cos(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))];
R06 = [ cos(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - sin(fi(6))*(cos(fi(4))*sin(fi(1)) - sin(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), - sin(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - cos(fi(6))*(cos(fi(4))*sin(fi(1)) - sin(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), sin(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) + cos(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))));
cos(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))) + sin(fi(6))*(sin(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(fi(4))),   cos(fi(6))*(sin(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(fi(4))) - sin(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))), sin(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) - cos(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))));
                                                                                                - cos(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - sin(fi(4))*sin(fi(6))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                                                                     sin(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - cos(fi(6))*sin(fi(4))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                         - sin(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*cos(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))];
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

end

function Q = rownania(fi)
global q;
a=11; b=14; c=6.3; d=6.3; e=3.3; z=8.5;

W = [cos(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) + sin(fi(1))*sin(fi(4))*(d + cos(fi(5))*(e + z));
 sin(fi(1))*(cos(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + sin(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))) - cos(fi(1))*sin(fi(4))*(d + cos(fi(5))*(e + z));
                                                   a - sin(fi(2))*(sin(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) + cos(fi(3))*sin(fi(5))*(e + z)) + cos(fi(2))*(b + cos(fi(3))*(c + cos(fi(4))*(d + cos(fi(5))*(e + z))) - sin(fi(3))*sin(fi(5))*(e + z))];
R06 = [ cos(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - sin(fi(6))*(cos(fi(4))*sin(fi(1)) - sin(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), - sin(fi(6))*(cos(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) - sin(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))))) - cos(fi(6))*(cos(fi(4))*sin(fi(1)) - sin(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2)))), sin(fi(5))*(cos(fi(1))*cos(fi(2))*cos(fi(3)) - cos(fi(1))*sin(fi(2))*sin(fi(3))) + cos(fi(5))*(sin(fi(1))*sin(fi(4)) + cos(fi(4))*(cos(fi(1))*cos(fi(2))*sin(fi(3)) + cos(fi(1))*cos(fi(3))*sin(fi(2))));
cos(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))) + sin(fi(6))*(sin(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(fi(4))),   cos(fi(6))*(sin(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))) + cos(fi(1))*cos(fi(4))) - sin(fi(6))*(cos(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) + sin(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))))), sin(fi(5))*(cos(fi(2))*cos(fi(3))*sin(fi(1)) - sin(fi(1))*sin(fi(2))*sin(fi(3))) - cos(fi(5))*(cos(fi(1))*sin(fi(4)) - cos(fi(4))*(cos(fi(2))*sin(fi(1))*sin(fi(3)) + cos(fi(3))*sin(fi(1))*sin(fi(2))));
                                                                                                - cos(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - sin(fi(4))*sin(fi(6))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                                                                     sin(fi(6))*(cos(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*sin(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))) - cos(fi(6))*sin(fi(4))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3))),                                                         - sin(fi(5))*(cos(fi(2))*sin(fi(3)) + cos(fi(3))*sin(fi(2))) - cos(fi(4))*cos(fi(5))*(sin(fi(2))*sin(fi(3)) - cos(fi(2))*cos(fi(3)))];

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

Q=Q0-q;
end