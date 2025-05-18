clear
close all
clc

%% 1

clear
close all
clc

%% 2

clear
close all
clc

n=23;

A = gallery('lehmer', n);

b = ones(n, 1);

R = chol(A);

R(7, 8)

y = fwsub(R', b)
min(y)

costo = 1/3 * n^3 + 2*n^2

%% 3

clear
close all
clc

%% 4

clear
close all
clc

A = gallery('lehmer', 13);

sdp(A)

toll = 1e-3;

D = qrbasic(A, toll, 1e3)

condA = max(D) / min(D)


%% 5
clear
close all
clc

%% 6

clear
close all
clc


alpha = 0;

f = @(x) exp(3*x^2) - 1;

df = diff(str2sym(func2str(f)))
d2f = diff(df)

d1f = double(subs(df, alpha))
d2f2 = double(subs(d2f, alpha))

% [xVect, iter] = bisez(-1, 1, 1e-4, f)

[xVect, iter] = newton(1, 1e3, 1e-5, f, matlabFunction(df))

stimap(xVect)

%% 7

clear
close all
clc

f = @(x) x + 1/(2*pi) * cos(pi * x);

[xvect, iter] = ptofis(1/4, f, 1e3, 1e-4)

xvect(11) - 0.5





%% 8

clear
close all
clc


xEx = [0 0]';

x0 = [1/4 1/3]';

Phi = @(y1, y2) 1/2 * y1^2 + (1 - y1/2) * y2^2

GradPhi = gradient(str2sym(func2str(Phi)))

HessPhi = jacobian(GradPhi)

GradPhi = matlabFunction(GradPhi)

HessPhi = matlabFunction(HessPhi)

GRADPHI = @(y1,y2)[y1-y2.^2./2; y2.*(y1./2-1).*-2];

HESSPHI = @(y1, y2) [1,-y2; -y2,-y1+2];

[xVect, iter] = newton_opt(GRADPHI, HESSPHI, x0, 0, 5)