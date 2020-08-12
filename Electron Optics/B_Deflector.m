function [defl] = B_Deflector(ur,inputArg2)
%B_DEFLECTOR Single sided  calculations of magnetic deflection
%   Detailed explanation goes here
    mu = u0*ur;
    B_loop = mu*N*I/(2*R); %Tesla

    B = B_loop; %Simple override for electron in constant feild flat region
    L = 2*R;    %simply model of loop length
    r = sqrt(2*Me/Qe) * sqrt(Vl)/B ; %radius of curvature (m) for electron in B feild

    defl_exit = (r - sqrt(r^2 - L^2)); %Circular exit point

    % plots out trajectories
    for i = 1:n

        if (x(i)<L)
            defl(i) = r - sqrt(r.^2 - (x(i))^2);
        else
            defl(i) = defl_exit + (x(i)-L)*L/(r-defl_exit);            
        end
    end
end

