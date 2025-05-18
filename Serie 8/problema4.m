function fn = problema4(t, y)

fn = zeros(size(y, 1), length(t));

g = @(t) exp(-t/2) * (2*cos(t) - 7/2*sin(t)) + 40*exp(-t)*sin(t)^2;

fn(1) = y(2);
fn(2) = -2*y(2) - 10*y(1)^2 + g(t);

end