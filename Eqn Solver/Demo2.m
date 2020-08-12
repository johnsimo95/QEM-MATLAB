syms x y
eqn1 = sin(x)+cos(y) == 4/5;
eqn2 = sin(x)*cos(y) == 1/10;
a = axes;
fimplicit(eqn1,[-2*pi 2*pi],'b');
hold on
grid on
fimplicit(eqn2,[-2*pi 2*pi],'m');
L = sym(-2*pi:pi/2:2*pi);
a.XTick = double(L);
a.YTick = double(L);
M = arrayfun(@char, L, 'UniformOutput', false);
a.XTickLabel = M;
a.YTickLabel = M;
title('Plot of System of Equations')
legend('sin(x)+cos(y) == 4/5','sin(x)*cos(y) == 1/10',...
    'Location','best','AutoUpdate','off')