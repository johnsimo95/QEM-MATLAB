% Using Shooting Newton Method
clear;
clf;


y_min = -3;
initialValue1 = 0;
initialValue2 = 10^-50;
hLogLower = -4; %10^hLogLower lower h bound
hLogUpper = -4; %10^hLogHigher upper h bound
hIndex = 0;
iter=0;
maxIter = 10000;

ElowerInit = 1;
EupperInit = 1.2;
eigError = 10^-12;
%Can set N manually too, just like this scheme better since clearer

for h = logspace(hLogLower, hLogUpper, (hLogUpper-hLogLower +1))
    Elower = ElowerInit;
    Eupper = EupperInit;
    E = (Eupper+Elower)/2;
    iter = 0;
    
    while 1
        N = -ceil(y_min/h); %forces integer treatment...

        j = linspace(-N, 1, N+2);   %Maps indexing space to real space through h


        y = j*h;                %Maps indexing space to real space through h

        j_full = linspace(-N, N, 2*N+1);
        y_full = j_full*h;      %Maps for full gaussian calculations
        normCalc = 0;

        psiExact = PsiExact(y_full, 1);
        probExact = ProbExact(y_full,1);
        v = Quart_Pot(y);

        %Tests function
%         figure(1);
%         plot(y_full, psiExact);
%         hold on;
        %plot(y , v/10);

        psiCalc = zeros(1,N);
        psiCalc(1) = initialValue1; %sets furthest boundary
        psiCalc(2) = initialValue2; %sets next value

        for n = 2:N+1
            % Simple scheme
            % psiCalc(n+1) = (-E*(h^2)+2+(h^2)*v(n))*psiCalc(n) - psiCalc(n-1);

            % Noumerov Scheme
            psiCalc(n+1) = ((24+10*h^2*v(n)-10*h^2*E)*psiCalc(n)+(-12+h^2*v(n-1)-E*h^2)*psiCalc(n-1))/(E*h^2+12-h^2*v(n+1));
        end 

        psiCalcFlip = flip(psiCalc);
        psiCalcFlip = psiCalcFlip(4:end);
        psiCalcFull = [psiCalc, psiCalcFlip];

        probCalc = psiCalcFull.^2;


        normCalc = h*sum(probCalc);
        normExact = h*sum(probExact);
        
        psiCalc = psiCalc/sqrt(normCalc);%Normalize original psicalc
        psiFinal = psiCalcFull/sqrt(normCalc);


        %% Now error analysis
        iter = 1+iter;
        
        if(iter>maxIter)
            disp("Convergence Failed");
            break;
        end
        
        if(eigError)>abs(psiCalc(end)-psiCalc(end-2))
            disp("Solved!");
            break;
        elseif psiCalc(end)>psiCalc(end-2) %wavefunction diverging up, energy too low
            disp("Elow, psiHigh!");
            Elower = E;
            E = (Eupper+Elower)/2;
        elseif psiCalc(end)<psiCalc(end-2) %wavefunction diverging down, energy too high
            disp("Ehigh, psiLow!");
            Eupper = E;
            E = (Eupper+Elower)/2;
        end

    end

    figure(1);
    hold on;
    plot(y_full , psiFinal)
    plot(y_full, psiExact);
    
    
    hIndex = hIndex+1;
    wError(hIndex) = 1/N*sum(abs(psiFinal-psiExact));

end

% % Error Plot
% 
% figure(2);
% title("3pt Shooting Newton Error")
% xlabel("h")
% ylabel("Error Sum (w(h))")
% h = logspace(hLogLower, hLogUpper, hLogUpper - hLogLower +1);
% 
% loglog(h, wError, '-s');
% legend("Error", "O(h^4)");
% hold on
% loglog(h, h.^4,'--');


grid on;