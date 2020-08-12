%% Eigenvalue solver for calculating the lowest solutions of a given hamiltonian matrix (for MIT 6.728)
clear;
clc;
format short;

%% Part C Code
h11 = 1 - 40/pi*(0.956610);
h13 = 40/pi*3*sqrt(3)/8;
h31 = h13;
h33 = 9 - 40/6;

H3 = [h11 h13; h31 h33];

[V3, D3] = eig(H3);

%parameterized function of x, with inputs a, b
fun = @(x, a, b) sin(a.*x).*sin(b.*x);

%Max iteration number
Nmax = 10;

for j = 1:Nmax;
    H = zeros(j,j);
    
    for n = 1:j
        for m = 1:j
            if (m == n)
                H(m,n) = (2*m-1)^2 - 40/pi*integral(@(x)fun(x,2*m-1,2*n-1),pi/3,2*pi/3); %Doing 1, 3, 5...
            else
                H(m,n) = -40/pi*integral(@(x)fun(x,2*m-1,2*n-1),pi/3,2*pi/3);
            end
        end
    end
    
    [V, D] = eig(H);
    
    A(j).coefficiencts = V;
    A(j).eigenvalues = D;
    
    E1(j) = D(1,1);
    E2(j) = 0;
    
    if j>=2
        E2(j) = D(2,2);
    end
    
end

mark = 's';
domain = 1:Nmax;

figure(1)
plot(1:Nmax, E1,mark, 2:Nmax, E2(2:Nmax), mark);
title("Energy Eigenvalues v.s. # of Basis Functions");
xlabel("Number of Basis Functions");
ylabel("Energy Value");
legend('E_1', 'E_2')

T = [domain; E1; E2]
points = 1000;


%% Part D Code
y = linspace(0, pi, points);
coeff = A(10).coefficiencts(:,1)
psi = zeros(1, points);


for index = 1:10
    psi = psi + coeff(index) * demo(y, 2*index-1);
end

figure(2)
plot(y, -psi, y, demo(y,1));
title("Sum of 10 Basis Functions for Ground State");
xlabel("y");
ylabel("\psi");
legend('\psi_{calc}', '\psi_{single}')
axis([0 pi 0 1.2]);


