function test()
    clear; clc;
    global target;
    fun = @rownania;
    fi0 = [0.001, 0.001, 0.001, 0, 0.001, 0.001]';
    i = 0;
    k=0;
    
    for x = [15:0.2:35]
        for y = [0:0.1:0]
            for z = [15:0.2:35]       
                i = i+1
                target = [x, y, z, 0, pi, -pi/2]';
                fi = fsolve(fun,fi0);
                Q=Q0(fi);
                W(i,:) = [x, y, z, 1];
                
                if Q(1)<(x-0.1)||Q(1)>(x+0.1)  
                    W(i,4) = -1;
                end
                
                if Q(2)<(y-0.1)||Q(2)>(y+0.1)  
                    W(i,4) = -2;
                end
                
                if Q(3)<(z-0.1)||Q(3)>(z+0.1)  
                    W(i,4) = -3;
                end
                
                if Q(4)<(pi/2-0.2)||Q(1)>(pi/2+0.2)  
                    W(i,4) = -4;
                end
                
                if Q(5)<(pi-0.2)||Q(5)<(-pi+0.2)  
                    W(i,4) = -5;
                end
                
                if Q(6)<(-pi/2-0.2)||Q(6)>(-pi/2+0.2)  
                    W(i,4) = -6;
                end

                if(W(i,4)==1)
                   k=k+1; 
                end
            end
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

function Q0 = Q0(fi)
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
end
