function [Z] = xZ_Microstrip(er, w, h, t)
%Simply impedence of a single bar over an infinite ground plane
%   https://technick.net/tools/impedance-calculator/microstrip/
if (((w/h) > 0.1) && ((w/h) < 3))
    Z = 87/sqrt(er+1.41)*log(5.98*h/(0.8*w+t));
else
    disp("ERROR out of valid bound");
    Z = 0;
end
end

