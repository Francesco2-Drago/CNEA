function fn = mms(t, y)

% x'' + gamma*x' + omega^2*x = 0
% x'' = -gamma*x' - omega^2*x


% y(1) = x
% y(2) = x'

% y(1)' = y(2)
% y(2)' = -gamma*y(2) - omega^2*y(1)

gamma = 0.1;
omega = 1;

[n, m] = size(y);

fn = zeros(n, m);

fn(1) = y(2);
fn(2) = -gamma*y(2) - omega^2*y(1);

end