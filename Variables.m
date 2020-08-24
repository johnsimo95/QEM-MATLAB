%% Variables
%  This code initializes all of my workspaces with valuable constants
cd C:\Users\johns\Documents\Github\QEM-MATLAB

c.nano = 1e-9;
c.micro = 1e-6;
c.milli = 1e-3;
c.kilo = 1e3;
c.mega = 1e6;
c.giga = 1e9;

% Physical Constants
% From https://en.wikipedia.org/wiki/List_of_physical_constants
c.e0_SI = 8.8541878128e-12; %F/m
c.u0_SI = 4*pi*10^-7; %H/m
c.e_SI = 1.60217646e-19; %Coulombs
c.me_SI = 9.1093837015e-31; %kg electron mass
c.mp_SI = 1.67262192369e-27; %kg proton mass
c.mn_SI = 1.67492749804e-27; %kg neutron mass
c.a_o_SI = 5.29177210903e-11; %m bohr radius
c.hbar_SI = 1.054571817e-34; %J*s
c.h_SI = 6.62607015e-34; %J*s
c.Zo_SI = 376.730313668; %Vacuum impedence (Ohms)
c.N_Av_SI = 6.02214076e23; %Avagadro constant (1/mol)
c.kb_SI = 1.380649e-23; %J/k Boltzmann Constant
c.u_bohr_SI = 9.2740100783e-24; %J/T Bohr magneton
c.eRestMass_eV = 0.51099895e6; % eV for electron
c.hc_eVnm= 1239.84; %eV*nm plank constant times c


save ImpVariables.mat;