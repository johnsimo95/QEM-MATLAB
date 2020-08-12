% Trace Inductance Calculator

% Using notes here:
% onenote:https://d.docs.live.net/06734d084ba63fb2/Documents/Research/Gated%20Mirror%20%5eM%20GaN%20(GANxGEM).one#200521%20Improved%20Circuit/Injection%20Modeling&section-id={96A45336-81E9-47CC-BDB4-69155451F1C4}&page-id={D088F97E-A23A-FA44-9975-926AC1635EDC}&end
% ON/GANxGEM/200521 Improved Circuit/Injection Modeling
% Constants/scaling
mm = 1e-3; %to get units to meters
ur = 1; % no permitivity

% First we sum the traces here.

l_top = (1.46 +0.82 + 1.18 + 0.33)*mm; %Top of board from via to via in m
l_bot = 3.42*mm; % Bottom of board direct via to via in m
w_top = 0.257*mm; % thinnest part in m
w_bot = 1.316*mm; %m finite ground return path

height = 0.1*mm; %m is board thickness
traceThick = 0.05*mm; %m thickness of traces

L_bar = Le_bar(ur, l_top, height, w_top, traceThick)
L_gnd = Le_gnd(ur, l_bot, height, w_bot, traceThick)