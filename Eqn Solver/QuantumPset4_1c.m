clear;
syms x
% %% Test solutions (WORK)
% eqn1 = a*b + (c) == (d);
% eqn2 = a+b == (c)^2;
% eqn3 = a*b*c*d == 1;
% eqn4 = a == sin(c)*0+c;


% %% Want for pset
% Original Expressions
% eqn1 = sin(sqrt(3*pi^2-d^2)) == a*exp(-d)+b*exp(d);
% eqn2 = a*exp(-2*d)+b*exp(2*d) == c*exp(-2*i*sqrt(3*pi^2-d^2));
% eqn3 = sqrt(3*pi^2-d^2)*cos(sqrt(3*pi^2-d^2)) == -d*a*exp(-d) +b*d*exp(d);
% eqn4 = -2*d*a*exp(-2*d)+2*d*b*exp(2*d) == -2*c*sqrt(3*pi^2-d^2)*exp(-2*i*sqrt(3*pi^2-d^2));

% Reduced expressions
% eqn1 = sin(sqrt(3*pi^2-d^2)) == a*exp(-d)+b*exp(d);
% eqn2 = a*exp(-2*d)+b*exp(2*d)/(exp(-2*i*sqrt(3*pi^2-d^2))) == c*;
% eqn3 = sqrt(3*pi^2-d^2)*cos(sqrt(3*pi^2-d^2)) == -d*a*exp(-d) +b*d*exp(d);
% eqn4 = -2*d*a*exp(-2*d)+2*d*b*exp(2*d)/(-2*sqrt(3*pi^2-d^2)*exp(-2*i*sqrt(3*pi^2-d^2))) == c;

% eqn1 = sin(sqrt(3*pi^2-d^2)) == a*exp(-d)+b*exp(d);

eqn1 = sqrt(x/(3-x))*cot(pi*x) == (sqrt(3-x) - i*sqrt(x) - (sqrt(3-x)+i*sqrt(x))*exp(-2*pi*sqrt(3-x)))/(sqrt(3-x) - i*sqrt(x) + (sqrt(3-x)+i*sqrt(x))*exp(-2*pi*sqrt(3-x)))
S = solve(eqn1, 'ReturnConditions', true);
sa = vpa(S.x)
%sb = vpa(S.b)
%sc = vpa(S.c)
%sd = vpa(S.d)

% a = axes;
% fimplicit(eqn1,[-2*pi 2*pi],'b');
% hold on
% grid on
% fimplicit(eqn2,[-2*pi 2*pi],'m');
% L = sym(-2*pi:pi/2:2*pi);
% a.XTick = double(L);
% a.YTick = double(L);
% M = arrayfun(@char, L, 'UniformOutput', false);
% a.XTickLabel = M;
% a.YTickLabel = M;
% title('Plot of System of Equations')
% legend('sin(x)+cos(y) == 4/5','sin(x)*cos(y) == 1/10',...
%     'Location','best','AutoUpdate','off')