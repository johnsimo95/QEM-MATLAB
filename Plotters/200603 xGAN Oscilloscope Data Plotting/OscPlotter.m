%% Oscilloscope Data Plotter
clear;
%addpath('190523_GAN');
mode = 1; %if mode = 1 just do single

% Vibration Reader/Plotter
ns = 10^-9;

%Checks data from current directory with frequency data
Files = dir

%slects files to read
n = 3; %which file to read/look at

 for n = 3:50
    name = Files(n).name

    % Override Autoread
    % name = 'C3anazingfinal100stepszoomevery10000047.dat';

    fileID = fopen(name,'rt');
    formatSpec = '%f %f';

    %A = fscanf(fileID,formatSpec)
    data = textscan(fileID, formatSpec);
    time = data(1);
    voltage = data(2);
    time = time{1}.';
    voltage = voltage{1}.';

    fclose(fileID);

    hold on
    test = plot(time/ns, voltage, 'b','linewidth',3);
    test.Color(4) = 0.5; %sets transparency
 end

%xlim([-2.5 7.5]);
titleText = ['File ', name];
title(titleText);
xlabel('Time (ns)');
ylabel('Voltage (V)');

