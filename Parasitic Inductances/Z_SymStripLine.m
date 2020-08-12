function [z0_sst2] = Z_SymStripLine(er, w, h, t)
%Simply capacitance of a single bar between two infinite ground planes
%   https://www.eeweb.com/tools/asymmetric-stripline-impedance
e = 2.71828;
% heff = top spacing
% t = trace thickness
% w = trace width
m = (6*h)/(3*h + t);
Weff = w + (t/pi)*log(e/(sqrt((t/(4*h+t))^2 + ((pi*t)/(4*(w+1.1*t)))^m)));
b = 2*h+t;
D = w/2*(1+t/(pi*w)*(1+log(4*pi*w/t))+0.551*(t/w)^2);
z0_sst2 = 60/sqrt(er)*log(4*b/(pi*D));

%%ODDLY DO NOT USE...
if (((w/b)<0.35)||((t/b)<0.25)||((t/w)<0.11))
    disp("((w/b)<0.35)||((t/b)<0.25)||((t/w)<0.11)");
    z0ss = 377/(2*pi*sqrt(er))*log(1+8*h/(pi*Weff)*(16*h/(pi*Weff)+sqrt((16*h/(pi*Weff))^2+6.27)));
else
    z0ss = 94.15/((w/b)/(1-t/b)+z0sst2);
    disp("NOT (w/b)<0.35||(t/b)<0.25||(t/w)<0.11");

end

end

