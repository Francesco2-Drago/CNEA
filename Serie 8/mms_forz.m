function fn = mms_forz(t, y)

% x'' + gamma*x' + omega^2*x = - A0*sin(omegaf*t)
% x'' = -gamma*x' - omega^2*x + A0*sin(omegaf*t)


% y(1) = x
% y(2) = x'

% y(1)' = y(2)
% y(2)' = -gamma*y(2) - omega^2*y(1) + A0*sin(omegaf*t)

gamma = 0.1;
omega = 1;
A0 = 0.5;
omegaf = 0.5;

[n, m] = size(y);

fn = zeros(n, m);

fn(1) = y(2);
fn(2) = -gamma*y(2) - omega^2*y(1) + A0*sin(omegaf*t);

end