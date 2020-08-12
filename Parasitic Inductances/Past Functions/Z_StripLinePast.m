function [Z] = Z_StripLinePast(er, w, h, t)
%Simply capacitance of a single bar between two infinite ground planes
%   https://technick.net/tools/impedance-calculator/stripline/
if (((w/h) > 0.1) && ((w/h) < 2) && t/h < 0.25)
    Z = 60/sqrt(er)*log(1.9*(2*h+t)/(0.8*w+t));
else
    disp("ERROR out of valid bound");
    Z = 0;
end
end