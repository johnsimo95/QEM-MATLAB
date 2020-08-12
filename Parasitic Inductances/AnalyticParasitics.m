%% Model workspace for experimenting with inductances and capacitances of conductors
% function [L] = Le_bar(ur, l, h, w, t,)
% function [L] = Le_gnd(ur, l, h, w, t,)
% function [L] = Ltot_StripLine(ur, l, s, w)
% function [C] = C_Microstrip(er, l, w, h, t)
% function [Z] = Z_Microstrip(er, w, h, t)
% function [C] = C_StripLine(er, l, w, h, t)
% function [C] = Z_StripLine(er, w, h, t)

clear;

length = [1000]; %mm
width_line = [23]; %mm
thick_line = [1]; %mm Thickness of line
separation_gnd = [5]; %mm for stripline |||
height = [5]; %mm for microstrip ||
width_gnd = [1000];
thick_gnd = [1]; %mm thickness of ground
ur = 1; %rel permeabiulity
er = 1; %rel permitivity

%% Scaling
mm = 10^-3;
thick_line = thick_line*mm;
thick_gnd = thick_gnd*mm;
length = length*mm;
width_line = width_line*mm;
height = height*mm;
separation_gnd = separation_gnd*mm;
width_gnd = width_gnd*mm;

%% Plotting

%Zstrip = Z_StripLine(er, width_line, height, thick_line)    %height is | <-> |      | distance between trace/gnd


% %% Testing Functions
% % Stripline formula consistent with site
% Lstrip = Ltot_StripLine(ur, length, separation_gnd, width_line)
% 
% Cmic = C_Microstrip(er, length, width_line, height, thick_line)
 Zmic = Z_Microstrip(er, width_line, height, thick_line)
% 
% Cstrip = C_StripLine(er, length, width_line, height, thick_line) %height is | <-> |      | distance between trace/gnd
% Zstrip = Z_SymStripLine(1, 0.01, 0.02, 0.005)    %height is | <-> |      | distance between trace/gnd

%% Geometry Encoding
%   Basic idea is we define a vector such that each component corresponds
%   to a region with different epsilon, 