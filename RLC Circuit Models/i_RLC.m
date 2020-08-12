function [i] = i_RLC(R,L,C,t,Vstep)
%RLC computes current of step function response
%   Detailed explanation goes here
B = sqrt(((R/(2*L)))^2-1/(L*C));

i = real(Vstep/(2*B*L).*(exp(B.*t-R.*t/(2*L))-exp(-B.*t-R.*t/(2*L))));

end

