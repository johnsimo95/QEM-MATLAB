% Capacitance/Inductance calculators
% Symmetric parralel plate values

mm = 10^-3;
e0 = 8.854E-12;
u0 = 4*pi*10^-7;

%Simple Kimball Model with external circuit
sepKim = 0.1*mm;
lenKim = 3*mm;
widKim = 3*mm;
muKim = 1 * u0;
epKim = 4 * e0;

% For single plate structure
C_Kimb = epKim*lenKim*widKim/sepKim;
L_Kimb = muKim*sepKim*lenKim/widKim;

% For double plate (on each side)
C_Kimb = C_Kimb*2
L_Kimb = L_Kimb/2