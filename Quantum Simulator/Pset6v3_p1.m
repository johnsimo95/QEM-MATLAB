% Using Shooting Newton Method
clear;
clf;


y_min = -10;
initialValue1 = 0;
initialValue2 = 10^-100;
hLogLower = -4; %10^hLogLower lower h bound
hLogUpper = -0; %10^hLogHigher upper h bound
hIndex = 0;
E = 1.000000001;
%Can set N manually too, just like this scheme better since clearer

for h = logspace(hLogLower, hLogUpper, hLogUpper - hLogLower +1)
    hIndex = hIndex+1;
    N = -ceil(y_min/h);

    j = linspace(-N, 1, N);
    maxIndex = size(j);
    maxIndex = maxIndex(2);
    index = 1:maxIndex:1;
    j_full = linspace(-N, N, 2*N+1);
    y = j*h;
    y_full = j_full*h;
    normCalc = 0;

    psiExact = PsiExact(y_full, 1);
    psiExactRed = PsiExact(y, 1);
    probExact = ProbExact(y_full,1);
    v = SHO_Pot(y);

    %Tests function
    figure(1);
    plot(y_full, psiExact);
    hold on;
    %plot(y , v/10);

    psiCalc = zeros(1,N);
    psiCalc(1) = initialValue1; %sets furthest boundary
    psiCalc(2) = initialValue2; %sets next value

    for n = 2:N-1
        psiCalc(n+1) = (-E*(h^2)+2+(h^2)*v(n))*psiCalc(n) - psiCalc(n-1);
    end 

    probCalc = psiCalc.^2;

    normCalc = h*sum(probCalc)*2;%Double since only do half!
    normExact = h*sum(probExact); 

    psiCalc = sqrt(probCalc/normCalc);

    plot(y , psiCalc)

    %% Now error analysis
    wError(hIndex) = 2/N*sum(abs(psiCalc-psiExactRed)); %(x2 since only plot half)
end

%% Error Plot

figure(2);
title("3pt Shooting Newton Error")
xlabel("h")
ylabel("Error Sum (w(h))")
h = logspace(hLogLower, hLogUpper, hLogUpper - hLogLower +1);
loglog(h, wError, '-s');
legend("Error");
% hold on
% h2Plot=loglog(h, h.^2);
% legend("h^2 Error");
grid on;