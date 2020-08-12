% Calculator for
%   - Ball bearing spacing
%       -Straight hole
%       -Tapered hole

%% Straight Hole
% ALL UNITS CONSISTENT (mm/in/mil)

R = 2;      % Ball Radius
R1 = 1.588;     % Hole 1 radius
R2 = R1;     % Hole 2 radius

dtop = sqrt(R^2 - R1^2);
dbot = sqrt(R^2 - R2^2);

d = dtop+dbot;

disp("Flat Hole spacing is " + num2str(d) +" units");

% Tapered hole
