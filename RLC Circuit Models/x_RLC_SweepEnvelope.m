%ABANDONED
% Found better method of removing oscillations manually for underdamped
% envelope function..
%% Calculator for RLC Circuits
Rs = 0.5; %Ohms, from multiple sources
Ls = 5.16; %Inductance, in nH
Cs = 10; %Capacitancem in pH

Vstep = 1; %Voltage in V
t_start = 0; %start time in ns
t_stop = 30; %stop time in ns
t_res = 0.1; %resolution in ns
t_env = 10; %extra space for calculating hilbert envolope
%t_offset = 10; %number of ns to plot before
%% Scaling
n = 10^-9; %scaling nano factor
p = 10^-12; %scaling pico factor
t_start = t_start*n;
t_stop = t_stop*n;
t_res = t_res*n;

t = linspace(t_start, t_stop, 2+(t_stop-t_start)/t_res);
R = Rs;
L = n*Ls;
C = p*Cs;

%% Labeling
Rst = "R=" + num2str(Rs) + "Ohm ";
Cst = "C=" + num2str(Cs)+ "pF ";
Lst = "L=" + num2str(Ls) + "nH ";


i = real(Vstep/(2*B*L).*(exp(B.*t-R.*t/(2*L))-exp(-B.*t-R.*t/(2*L))));
%v = -real(Vstep/(2*B*L*C)*(1/(-R/(2*L)+B)*exp(-R.*t/(2*L)+B.*t)- 1/(-R/(2*L)-B)*exp(-R.*t/(2*L)-B.*t)));
v = RLC(R,L,C,t,Vstep);
%%Parameter sweep;


%% Graphing
hold on;
ln = plot([-t_offset, t*10^9],[Vstep,v]*100);
ln.LineWidth = 1;
title('RLC Circuit Response');
xlabel('Time (ns)');
ylabel('Voltage Error (%)');
xlim([t_start t_stop]);
A = [Rst+Lst+Cst];
legend(A);
ln = plot([-t_offset, t*10^9],[Vstep,abs(hilbert(v))]*100);
ln.LineWidth = 2;

%% RLC Sweep (modify variable)
vstart = 3;
vinc = 2;
vstop = 7;

for Rs =vstart:vinc:vstop
    R = Rs;
    L = n*Ls;
    C = p*Cs;
    Rst = "R=" + num2str(Rs) + "Ohm ";
    Cst = "C=" + num2str(Cs)+ "pF ";
    Lst = "L=" + num2str(Ls) + "nH ";
    
    v = RLC(R,L,C,t,Vstep);
    
    ln = plot([-t_offset, t*10^9],[Vstep,v]*100);
    ln.LineWidth = 1;
    A = [A Rst+Lst+Cst];
    legend(A);
end