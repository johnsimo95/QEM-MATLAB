function [C] = C_StripLine(er, l, w, h, t)
%Simply capacitance of a single bar between two infinite ground planes
%   https://technick.net/tools/impedance-calculator/stripline/
if (((w/h) > 0.1) && ((w/h) < 2) && t/h < 0.25)
    C = l*5.55e-11*er/(log(3.81*h/(0.8*w+t)));
else
    disp("ERROR out of valid bound");
    C = 0;
end
end

