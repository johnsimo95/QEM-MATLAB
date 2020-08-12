function [deltaX] = Deflector(D, W, L, Vd, Vl)
%DEFLECTOR Summary of this function goes here
%   Detailed explanation goes here
deltaX = 0.5.*D./W.*Vd./Vl.*L + 1/4.*(D.^2)./W.*Vd./Vl;
end

