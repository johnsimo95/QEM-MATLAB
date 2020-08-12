function [v] = v_RLC(R,L,C,t,Vstep)
%RLC computes voltage of step function response
%   Detailed explanation goes here
B = sqrt(((R/(2*L)))^2-1/(L*C));

v = -real(Vstep/(2*B*L*C)*(1/(-R/(2*L)+B)*exp(-R.*t/(2*L)+B.*t)- 1/(-R/(2*L)-B)*exp(-R.*t/(2*L)-B.*t)));

end

