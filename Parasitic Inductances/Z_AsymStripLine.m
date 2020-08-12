function [Z] = Z_AsymStripLine(er, w, h1, h2, t)
%Simply capacitance of a single bar between two infinite ground planes
%   https://www.eeweb.com/tools/asymmetric-stripline-impedance
% e = 2.71828;
% h1 = top spacing
% h2 = bottem spacing
% t = trace thickness
% w = trace width
heff = (h1 + h2)/2;
m = (6*heff)/(3*heff + t);
z0air = 2 
X2 = sqrt(16*(h/Weff)^2*((14*er+8)/(11*er))^2 + ((er+1)/(2*er))*(pi^2));

Z = 377/(2*pi*sqrt(2)*sqrt(er+1))*log(1+4*(h/Weff)*(X1+X2));

end

