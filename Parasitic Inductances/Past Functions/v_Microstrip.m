function [v] = v_Microstrip(er)
%Simply velocity of a single bar over an infinite ground plane
%   https://technick.net/tools/impedance-calculator/microstrip/
if (w/h < 0.1 || w/h > 3)
    t_pd = 3.34e-9 * sqrt(0.475*er+0.67);
    v = 1/t_pd;
else
    disp("ERROR out of valid bound");
    v = 0;
end
end

