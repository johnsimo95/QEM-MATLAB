function [L] = Le_gnd(ur, l, h, w, t)
%   Partial inductance of ground plane, where w, t are the width and thickness
%   of the gnd respectively, h the separation and l the length

%   Simple low freqency model (valid ~2MHz for skinny bar (1mm wide, 100um
%   above) for inductance.

%   From :
%   Signal Integrity and Radiated Emission of High-Speed Digital Systems
%   Appendix A
pi = 3.14159;

mu0 = 4*pi*10^7;
mu = mu0*ur;

L = mu/(2*pi)*l*log((w+t+pi(h-t/2))/(w+(1+pi/2)*t));
end

