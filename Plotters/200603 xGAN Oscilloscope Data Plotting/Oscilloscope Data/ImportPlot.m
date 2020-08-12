filename = 'C3LMG1020_Bad_Layout_NoFilter_700MHzProbe00001.csv';

output = csvread(filename,6,0);

plot(10^9*output(:,1),output(:,2), 'linewidth', 2)
xlabel('Time (ns)')
ylabel('Voltage (V)')
