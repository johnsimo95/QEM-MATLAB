%Calculator for RLC Circuits
% Code Summary:
% In this code, we calculate RLC circuit parameters exactly for a lumped
% RLC circuit, in series measuring the voltage accross the capacitor. This
% code is capable of taking a single RLC combination then plot its step
% response, and in the case of underdamped solutions its envelope.
%
% One nice feature is that we can sweep the values manually and plot these
% changes and record them automatically. THere is also a structure named
% "data" that holds all of our past values and the time that either the
% envelope or function reaches a specified accuracy. This operates by
% running the full code to start, initializing the first value and
% workspace, than running only the section Repeated code with ctrl+Enter

% Conclusion
% It seems slight underdampening is the optimal conditions for our
% circuitry

%% Single run for time array
clear;
clf;
iter = 0; %Resets

%% Repeated Code
Rs = 10; %Ohms, from multiple sources
Ls = 6.16; %Inductance, in nH
Cs = 15; %Capacitancem in pH

Vstep = 1; %Voltage in V
t_start = 0; %start time in ns
t_stop = 50; %stop time in ns
t_res = 0.05; %resolution in ns
t_offset = 10^-9; %Graphing offset time
tol = 0.00001; % Range to define critical dampening
Accuracy = 0.01; % Required Accuracy of circuit to give time to complete

iter=iter+1;

 

%Scaling
n = 10^-9; %scaling nano factor
p = 10^-12; %scaling pico factor
R = Rs;
L = n*Ls;
C = p*Cs;
t_start = t_start*n;
t_stop = t_stop*n;
t_res = t_res*n;
t = linspace(t_start, t_stop, 2+(t_stop-t_start)/t_res);

%Labeling
Rst = "R=" + num2str(Rs) + "Ohm ";
Cst = "C=" + num2str(Cs)+ "pF ";
Lst = "L=" + num2str(Ls) + "nH ";

%Funtion declaration
thresh = 2*sqrt(L/C);
B = sqrt(((R/(2*L)))^2-1/(L*C));

v = v_RLC(R,L,C,t,Vstep);



%Graphing
hold on;
grid on;
ln = plot([-t_offset t*10^9],[Vstep v]*100,'DisplayName', Rst+Lst+Cst);
title('RLC Circuit Response')
xlabel('Time (ns)');
ylabel('Voltage Error (%)');
legend('-DynamicLegend');
color = ln.Color;

%Envelope calculator
if (R<thresh-thresh*tol)
    %Oscillating full solution plot style
    %ln.LineStyle = NormStyle;
    %ln.Color = NormColor;

    %Envelope only solution (neglects osc)
    
    disp(Rst+Lst+Cst +" Underdamped");
    v = -real(Vstep/(2*B*L*C)*(1/(-R/(2*L)+B)*exp(-R.*t/(2*L)+0*B.*t)- 1/(-R/(2*L)-B)*exp(-R.*t/(2*L)-0*B.*t)));
    ln = plot([-t_offset, t*10^9],[100, v*100], '--', 'DisplayName', Rst+Lst+Cst+" env.", 'Color', color);
    ln.LineWidth = 1;

end

%Find Envelope Threshold time

t_out = find( v < Accuracy );
data(iter).t = t(t_out(1));
data(iter).R = R;
data(iter).L = L;
data(iter).C = C;