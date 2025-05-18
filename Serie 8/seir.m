function fn = seir(t, y)

beta = 0.7586;
alpha = 1/5.2;
gamma = 1/2.9;

if t>=80
    beta = 0.25;
    if t>=120
        beta = 0.65;
    end
end

fn = zeros(size(y, 1), length(t));

N = 1e7;

fn(1) = -beta * y(1) * y(3) / N;
fn(2) = beta * y(1) * y(3) / N -alpha*N + alpha*y(1) + alpha*y(3) + alpha*y(4);
fn(3) = alpha*N - alpha*y(1) - (alpha + gamma)*y(3) - alpha*y(4);
fn(4) = gamma*y(3);

end

% function f = seir( t, y )
% %
% % SEI-(R)
% % y( 1 ) = S
% % y( 2 ) = E
% % y( 3 ) = I
% 
% N = 1e7;
% 
% beta = 0.7586;
% % beta = 0.7586 * ( t < 80 ) + 0.25 * ( t >= 80 );
% % beta = 0.7586 * ( t < 80 ) + 0.25 * ( t >= 80 ) .* ( t < 120 ) + 0.65 * ( t >= 120 );
% 
% alpha = 1 / 5.2;
% gamma = 1 / 2.9;
% 
% [ n, m ] = size( y ); 
% f = zeros( n, m ); 
% 
% f( 1 ) = - beta * y( 1 ) .* y( 3 ) / N;
% f( 2 ) = beta * y( 1 ) .* y( 3 ) / N - alpha * y( 2 );
% f( 3 ) = alpha * y( 2 ) - gamma * y( 3 );
% 
% return