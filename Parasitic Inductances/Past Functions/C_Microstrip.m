function [C] = C_Microstrip(er, l, w, h, t)
%Simply capacitance of a single bar over an infinite ground plane
%   https://technick.net/tools/impedance-calculator/microstrip/
if (((w/h) > 0.1) && ((w/h) < 3))
    C = l*2.64e-11*(er+1.41)/(log(5.98*h/(0.8*w+t)));
else
    disp("ERROR out of valid bound");
    C = 0;
end
end

