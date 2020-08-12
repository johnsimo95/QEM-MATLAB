function [psiExact] = PsiExact(y, n)
% Ground state potential for testing
% Can expand from ground state using index n.... 
psiExact = 1/(pi^(1/4)).*exp((-y.^2)/2);
end

