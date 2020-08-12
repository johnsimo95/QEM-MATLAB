%% Converts LTSPICE .txt files to a MATLAB Matrix and plots

% Checks data from current directory with frequency data 
Files = dir;
checkThis = 2; % which file to read/look at
name = Files(checkThis).name;

fileID = fopen(name,'rt');
formatSpec = '%f\t%f';

%A = fscanf(fileID,formatSpec)
titles = textscan(fileID, '%s\t%s', 1);
data = textscan(fileID, formatSpec);
tit1 = titles{1};
tit2 = titles{2};
tit1 = tit1{1};
tit2 = tit2{1};

time = data(1);
voltage = data(2);
time = time{1}';
voltage = voltage{1}.';

fclose(fileID);

figure(1)
titleText = ['File ', name];
plot(time, voltage);
title(titleText);
xlabel(tit1);
ylabel(tit2);


%% interpolate to constant time step!
timeRes = 10E-12; % 10ps time resolution
interpTime = linspace(time(1), time(end), (time(end)-time(1))/timeRes+1);
interpVolt = interp1(time,voltage,interpTime, 'PCHIP');

figure(2)
titleText = ['Interpolated File ', name];
plot(interpTime, interpVolt);
title(titleText);
xlabel(tit1);
ylabel(tit2);