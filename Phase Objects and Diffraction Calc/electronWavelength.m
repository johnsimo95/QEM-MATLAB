function [lambda] = electronWavelength(KE)
%ELECTRONWAVELENGTH Summary of this function goes here
%   Detailed explanation goes here
addpath('C:\Users\johns\Documents\Github\QEM-MATLAB');
load ImpVariables.mat;

pc = (KE.^2 + 2.*KE*c.eRestMass_eV).^0.5 %output in eV still
lambda = c.hc_eVnm./pc*c.nano %wavelength in m

end

