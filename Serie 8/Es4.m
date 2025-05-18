% clear
close all
clc

% Punto 1

% Funzione del problema come problema4

% Punto 2

t0 = 0;
tmax = 10;

y0 = [0 2]';

h = 1e-2;
Nh = (tmax - t0) / h;

[tVect, uVect] = eulero_avanti_sistemi('problema4', [t0 tmax], y0, Nh);

uVect(:, 1);
uVect(:, end);

i = [];

idx = 1;

while idx<length(tVect) && isempty(i)
    if abs(uVect(1, idx:end)) < 0.1
        i = idx;
    else
        idx = idx + 1;
    end
end

tVect(i); %5.6800

% Punto 3

yEx = @(t) 2*exp(-t/2).*sin(t);

H = [1e-3 5*1e-4 2.5*1e-4 1.25*1e-4];

Err = [];

i = 1;

for h=H
    Nh = ceil((tmax - t0) / h);
    
    [tVect, uVect] = eulero_avanti_sistemi('problema4', [t0 tmax], y0, Nh);

    Err(i) = max(abs(uVect(1, :) - yEx(tVect)));

    i = i + 1;
end

% Punto 4

% E <= C*h^p
% Eh1 / Eh2 = (h1 / h2)^p
% p = log(Eh1 / Eh2) / log(h1 / h2)

p = log(Err(2:end) ./ Err(1:end-1)) ./ log(H(2:end) ./ H(1:end-1));
% 1.0141    1.0069    1.0034

% Punto 5

Jf = @(t) [0, 1; -20*yEx(t), -2];

T = linspace(t0, tmax, 1e3);

h = [];

for t=T
    lambda = eig(Jf(t))';

    hmax = -2*real(lambda) / abs(lambda).^2;

    h = [h, hmax];
end

hmax = min(h); % 0.0972

% Punto 6

h = 1e-2;
t0 = 0;
tmax = 10;
Nh = ceil(tmax - t0) / h;

[tVect, uVect] = multipasso_sistemi('problema4', [t0 tmax], y0, Nh);

uVect(:, 1); % 0; 2
uVect(:, 2); % 0.0200 1.9800
uVect(:, end); % -0.0073; -0.0076

Err = [];

i = 1;

for h=H
    Nh = ceil((tmax - t0) / h);

    [tVect, uVect] = multipasso_sistemi('problema4', [t0 tmax], y0, Nh);

    Err(i) = max(abs(uVect(1, :) - yEx(tVect)));

    i = i + 1;
end

p = log(Err(2:end) ./ Err(1:end-1)) ./ log(H(2:end) ./ H(1:end-1));
% 1.9996    1.9998    1.9999