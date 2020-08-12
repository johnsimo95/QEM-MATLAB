function [psiExact] = ProbExact(y, n)
% Ground state potential for testing
% Can expand from ground state using index n.... 
psiExact = 1/(pi^(1/2)).*exp((-y.^2));
end

