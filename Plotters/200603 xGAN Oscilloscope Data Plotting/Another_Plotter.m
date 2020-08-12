lBound = 0;
mBound = 0.01;
uBound = 0.05;
numPoints = 1000;

f = 10.4e9;
om = 2*pi*f;
c = 3e8;
eps0 =8.854e-12;
mu0=4*pi*1e-7;

kx = [147, 372];

%alpha = [342.6, 14.3];
alpha = [347.5, 62.8];

kz= [alpha(1)+ om^2/c^2, alpha(2)+ om^2/c^2];

x = linspace(lBound, uBound, numPoints);

Hy = zeros(numPoints, 2);
Ex = zeros(numPoints, 2);
Ez = zeros(numPoints, 2);


for m = 1:2
    H1 = cos(kx(1,m)*mBound)/(exp(-alpha(1,m) * mBound));

    for n = 1:numPoints
        z = x(n);
        if z < mBound
            Hy(n,m) = cos(kx(1,m) * z);
        else
            Hy(n,m) = (1)^(m)*H1*exp(-alpha(1,m) * z);
        end
    end

    figure(m)
    plot(x, Hy(:,m), 'lineWidth', 2);
    xlabel('x (cm)');
    ylabel('Normalized H-Field Amplitude');
    title('Hy Component');
end

for m = 1:2
    H1 = cos(kx(1,m)*mBound)/(exp(-alpha(1,m) * mBound));

    for n = 1:numPoints
        z = x(n);
        if z < mBound
            Ex(n,m) = (1/(om*eps0))*kz(m)*cos(kx(1,m) * z);
        else
            Ex(n,m) = (H1*(1/(om*eps0))*kz(m))*exp(-alpha(1,m) * z);
        end
    end

    figure(m+2)
    plot(x, Ex(:,m), 'lineWidth', 2);
    xlabel('x (cm)');
    ylabel('Normalized E-Field Amplitude');
    title('Ex Component');

end

for m = 1:2
    H1 = cos(kx(1,m)*mBound)/(exp(-alpha(1,m) * mBound));

    for n = 1:numPoints
        z = x(n);
        if z < mBound
            Ex(n,m) = (1/(om*eps0))*kz(m)*cos(kx(1,m) * z);
        else
            Ex(n,m) = (H1*(1/(om*eps0))*kz(m))*exp(-alpha(1,m) * z);
        end
    end

    figure(m+4)
    plot(x, Ex(:,m), 'lineWidth', 2);
    xlabel('x (cm)');
    ylabel('Normalized E-Field Amplitude');
    title('Ex Component');

end
