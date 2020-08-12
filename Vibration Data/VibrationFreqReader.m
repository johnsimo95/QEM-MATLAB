clear;
% Vibration Reader/Plotter

%Checks data from current directory with frequency data
Files = dir;
%slects files to read
n=3;
% DIMENSION to choose (XYZ)
row = 1;
dt=2.500000E-1;
name = Files(n).name

fileID = fopen(name,'rt');
formatSpec = '%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f';

%A = fscanf(fileID,formatSpec)
data = textscan(fileID, formatSpec, 'HeaderLines', 3);
intData = data(row);
xVib = intData{1,1};
nPoints = size(xVib);
nPoints = nPoints(1,1);

xVib=xVib.';
freqSpace = linspace(1, 1000, nPoints);

fclose(fileID);

sum = sum(xVib)

text = num2str(sum);
titleText = ['Location 3: Total = ', text];
plot(freqSpace,xVib);
title(titleText);
xlabel('Frequency (Hz)');
ylabel('Vibrations (m/s)');

grid minor