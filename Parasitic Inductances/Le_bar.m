function [L] = Le_bar(ur, l, h, w, t)
%Partial inductance of bar from L_p-M_p, incorporating mutal inductance
%   Where t is the thickness of the bar, w the width of gnd,  hieght 
%   h the separation and l the length

%   Simple low freqency model (valid ~2MHz for skinny bar (1mm wide, 100um
%   above) for inductance.

%   From :
%   Signal Integrity and Radiated Emission of High-Speed Digital Systems
%   Appendix A
pi = 3.14159;

mu0 = 4*pi*10^7;
mu = mu0*ur;

L = mu/(2*pi)*l*(log(2*h/(w+t))+3/2);

end

