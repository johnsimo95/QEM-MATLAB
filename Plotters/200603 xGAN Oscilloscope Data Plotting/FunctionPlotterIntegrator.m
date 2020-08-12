clear;
%% INPUTS
tau = 0.4; %ns
f0 = 10; %GHz

lowerTimeBound = -4;
upperTimeBound = 4;
numTimePoints = 4000;
t = linspace(lowerTimeBound, upperTimeBound, numTimePoints);

% FREQUENCY OUTPUT SPACE
lowerFreqBound = 2.5; %GHz
upperFreqBound = 17.5; %GHz
numFreqPoints = 4000;
f = linspace(lowerFreqBound, upperFreqBound, numFreqPoints);


TimeOut = zeros(numTimePoints,1);
TimeOut2 = zeros(numTimePoints,1);
FreqOut = zeros(numFreqPoints,1);
FreqOutUnnorm = zeros(numFreqPoints,1);

T= 0;
F= 0;
%% Time Check


EtimeArg = @(t) exp(1i*2*pi*f0*t).*exp(-t.^2./(2*tau^2));
EfreqArg = @(T,F) exp(1i*2*pi*(f0 - F)*T)*exp(-T^2/(2*(tau^2)));


%Check functions
for n = 1:numTimePoints
    TimeOut(n,1) = EtimeArg(t(n));
end


figure(1);
plot(t, TimeOut);
xlabel('Time (ns)');
ylabel('Amplitude');
%q = integral(fun,0,Inf)


%% define frequency space
sum = 0;
%Simple Integral
for m = 1:numFreqPoints
    sum=0;
    for n = 1:numTimePoints
        sum = sum + EfreqArg(t(n),f(m));
    end
    FreqOutUnnorm(m,1) = sum;
    FreqOut(m,1) = abs(sum)^2;
% %Evaluate Integral
% for n = 1:numTimePoints
%     Int(n) = real(integral(E,0,t(n)));
% end
end

figure(2);
plot(f, FreqOut);
xlabel('Frequency (GHz)');
ylabel('Amplitude');

%% Part b
L = 5;
Exp_b = @(T,F) exp(1i*2*pi*(F*T-5*(((F/(3e8))^2-(1/(2*0.02286)))^0.5)));

for m = 1:numTimePoints
    sum=0;
    for n = 1:numFreqPoints
        sum = sum + FreqOutUnnorm(n,1)*Exp_b(t(m),f(n));
    end
    TimeOut2(m,1) = real(sum);


end

figure(3);
plot(t, TimeOut2);
xlabel('Time (ns)');
ylabel('Amplitude');