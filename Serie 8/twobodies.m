function fn = twobodies(t, y)

% r'' = -4pi^2 * r / ||r||^3
% r(t0) = r0
% r'(t0) = v0

% y(1) = r
% y(2) = r(t0) = r0
% y(3) = r' = dr/dt = v
% y(4) = r'(t0) = v(t0) = v0

% y(1) = x
% y(2) = x' = dx/dt
% y(3) = y
% y(4) = y' = dy/dt

fn = zeros(size(y));

Norma = sqrt(y(1)^2 + y(2)^2);
fn(1) = y(2);
fn(2) = -4*pi^2 * y(1) / Norma^3;
fn(3) = y(4);
fn(4) = -4*pi^2 * y(3) / Norma^3;

end