% Using Shooting Newton Method
clear;
y_min = -10;
h = .001;
initialValue1 = 0;
initialValue2 = 10^-100;
%Can set N manually too, just like this scheme better since clearer
N = -y_min/h;

E = 1;
j = linspace(-N, 1, N);
j_full = linspace(-N, N, 2*N+1);
y = j*h;
y_full = j_full*h;
normCalc = 0;

probExact = ProbExact(y_full,1);
v = SHO_Pot(y);

%Tests function
clf;
figure(1);
plot(y_full, probExact);
hold on;
%plot(y , v/10);

psiCalc = zeros(1,N);
psiCalc(1) = initialValue1; %sets furthest boundary
psiCalc(2) = initialValue2; %sets next value

for n = 2:N-1
    psiCalc(n+1) = (-E*(h^2)+2+(h^2)*v(n))*psiCalc(n) - psiCalc(n-1);
end 

probCalc = psiCalc.^2;

normCalc = h*sum(probCalc)*2;%Double since only do half!
normExact = h*sum(probExact); 

plot(y , probCalc/normCalc)

%% Now error analysis
fig

    