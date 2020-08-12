function [L] = L_basic(ur, l, w, h)
% Simplest symmetric inductance of close plates
    l = 4*pi*10^-7 h*l/w;

end

