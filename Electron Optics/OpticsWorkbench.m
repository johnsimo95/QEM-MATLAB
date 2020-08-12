%% Testing Platform for electron optics formulas


clear;

% % Tells me if code has excecuted already without clearing
% if ~exist('VarName','var')
% VarName=0;
% end

% Fundamental constants
u0 = 4*pi*10^-7;
e0 = 8.854e-12;
Qe = 1.602e-19;
Me = 9.109e-31;
mm = 10^-3;
um = 10^-6;
nm = 10^-9;

% CONTROL
E_simple_plate = 1;
B_simple_loop = 0;
plotRes = 1;
% Plotting conditions
x_start = 0 * mm;
x_res = 0.1 * mm;
x_stop = 100 * mm; % 420mm from port to bottem
x = x_start:x_res:x_stop;
n = size(x);
n = n(2);

% if ~VarName
%     soln = x;
% end
    
%% Plot parallel plate electron trajectories
%units all work out without scaling
if (E_simple_plate == 1)
    
    D = 23 * mm; %mm plates length 50ohm 23mm
    W = 5* mm;  %mm plate sepearation 50hm 5mm
    Vd = 20; %volts across plate deflector
    Vl = 500; %voltage of high tension extractor (beam energy)

    for i = 1:n
        if (x(i)>D)
            defl(i) = Deflector(D, W, x(i)-D, Vd, Vl);
        else
            defl(i) = Deflector(x(i), W, 0, Vd, Vl);
        end
    end

    figure(1)
    plot(x/mm, defl/mm);
    title('Electron Trajectory')
    xlabel('Distance (mm)');
    ylabel('Deflection (mm)');
    divider = xline(D/mm,'--');

    %Plots MCP resolution
    if (plotRes == 1)
        pixelSize = 25*um; % Assumed size of pixel/MCPs spatially
        nPixels = defl/pixelSize; %plot of number of pixels available
        tSweep = 8*nm; %nanoseconds
        xResStart = 10*mm; %x axis plot range start
        timeRes = tSweep./nPixels;
        figure (2)
        plot(x/mm, timeRes/nm);
        title('Temporal Resolution')
        xlabel('Distance (mm)');
        ylabel('Resolution (ns)');
        divider = xline(D/mm,'--');
        xlim([xResStart/mm x_stop/mm]);
        grid minor;
    end
    
    %% Plot Magnetic Deflection (simple perfect field)trajectories
elseif (B_simple_loop == 1);
    I = 1000 *mm; %forcing to mA
    R = 10 *mm; %loop radius forcing to mm
    %L = 10 *mm; %interaction length of electron with field
    Vl = 2001; %Acceleraing voltage of ELECTRON
    N = 10; %# of loops
    B_loop = u0*N*I/(2*R); %Tesla

    B = B_loop; %Simple override for electron in constant feild flat region
    L = 2*R;    %simply model of loop length
    r = sqrt(2*Me/Qe) * sqrt(Vl)/B ; %radius of curvature (m) for electron in B feild

    defl_exit = (r - sqrt(r^2 - L^2));

    for i = 1:n

        if (x(i)<L)
            defl(i) = r - sqrt(r.^2 - (x(i))^2);
        else
            defl(i) = defl_exit + (x(i)-L)*L/(r-defl_exit);            
        end
    end

    hold on;
    %xline(L/mm,'--');
    Vst = "Vlen=" + num2str(Vl) + " V";
    Bst = ""; %" Bloop=" + num2str(B_loop) + " T";
    plot(x/mm, defl/mm, 'DisplayName', Vst+Bst);
    legend('-DynamicLegend');
    title('Electron Trajectory')
    xlabel('Distance (mm)');
    ylabel('Deflection (mm)');
    
    

end

% soln = [soln; defl];

% %Can tell that code excecuted already
% VarName = 1;