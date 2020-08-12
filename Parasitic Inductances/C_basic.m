function [outputArg1,outputArg2] = C_basic(er, l, w, h)
%basic calculator of capacitances
    C = er*8.854e-12*l*w/h;
end

