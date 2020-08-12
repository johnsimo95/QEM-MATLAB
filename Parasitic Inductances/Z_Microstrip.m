function [Z] = Z_Microstrip(er, w, h, t)
%Simply capacitance of a single bar between two infinite ground planes
%   https://www.eeweb.com/tools/microstrip-impedance
e = 2.71828;
Weff = w + (t/pi)*log(4*e/(sqrt((t/h)^2 + (t/(w*pi +1.1*t*pi))^2)))*(er+1)/(2*er);
X1 = 4*((14*er+8)/(11*er))*h/Weff;
X2 = sqrt(16*(h/Weff)^2*((14*er+8)/(11*er))^2 + ((er+1)/(2*er))*(pi^2));

Z = 377/(2*pi*sqrt(2)*sqrt(er+1))*log(1+4*(h/Weff)*(X1+X2));

end

