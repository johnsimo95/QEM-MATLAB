function [L] = Ltot_StripLine(ur, l, s, w)
%Full inductance of a stripline, with infinite ground planes and infinitely
%thin center conductor
%   Where w is the width of the bar, s the distance between grounds, with
%   the conductor at s/2 in between, l the length 

%   Unsure of model generality

%   From :
%   https://www.emisoftware.com/calculator/stripline/

u0 = 4*pi*10^7;
u = u0*ur;
c = 3*10^8;

if (w/s > 0.35)
    L = 30*pi*l/c*(1/(w/s+0.441));
else
    L = 30*pi*l/c*(1/((w/s)-((0.35-(w/s))^2)+0.441));
end

end

