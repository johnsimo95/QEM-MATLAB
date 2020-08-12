% Using Shooting Newton Method
clear;
clf;


y_min = -10;
initialValue1 = 0;
initialValue2 = 10^-100;
hLogLower = -4; %10^hLogLower lower h bound
hLogUpper = -4; %10^hLogHigher upper h bound
h = .1;
hIndex = 0;

Elower = 0.9;
Eupper = 1.5;
E = (Eupper+Elower)/2;
eigError = 10^-10;
%Can set N manually too, just like this scheme better since clearer

    while 1
        N = -ceil(y_min/h); %forces integer treatment...

        j = linspace(-N, 1, N+2);   %Maps indexing space to real space through h


        y = j*h;                %Maps indexing space to real space through h

        j_full = linspace(-N, N, 2*N+1);
        y_full = j_full*h;      %Maps for full gaussian calculations
        normCalc = 0;

        psiExact = PsiExact(y_full, 1);
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

        for n = 2:N+1
            psiCalc(n+1) = (-E*(h^2)+2+(h^2)*v(n))*psiCalc(n) - psiCalc(n-1);
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
        plot(y_full , psiFinal)

hIndex = hIndex+1;
wError(hIndex) = 2/N*sum(abs(psiCalcFull-psiExact)); %(x2 since only plot half)


%% Error Plot
% 
% figure(2);
% title("3pt Shooting Newton Error")
% xlabel("h")
% ylabel("Error Sum (w(h))")
% h = logspace(hLogLower, hLogUpper, hLogUpper - hLogLower +1);
% loglog(h, wError, '-s');
% legend("Error");
% % hold on
% % h2Plot=loglog(h, h.^2);
% % legend("h^2 Error");
% grid on;