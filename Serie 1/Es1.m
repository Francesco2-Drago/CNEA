%% 1.1

clear
clc

v1 = 2.^(0:10);
disp(v1)

v2 = cos(pi ./ (1:10))';
disp(v2)

v3 = 1 ./ (10 * 2.^(0:5));
disp(v3)

v4 = [];
for i=1:10
    v4 = [v4 (exp(1)^i + (-1)^(i-1) * (1 + i*5)) 0];
end

disp(v4)

%% 1.2

clear
clc

A = zeros(5) + 2 * diag(diag(eye(5))) + 10 * diag(diag(eye(3)),2) + ...
    diag(diag(40),4) + diag(5 * diag(eye(4)),-1) + ...
    diag(10 * diag(eye(3)),-2) + diag(diag(40),-4)

Asum = sum(sum(A))

A1 = A(1:3,1:3)

A2 = [A(1,1) A(1,2) A(1,2)
      A(3,1) A(2,1) A(1,2)
      A(5,1) A(1,2) A(2,1)]

A2 = A([1 3 5], [1 2 4])

A3 = [A(2,1) A(1,2) A(1,3)
      A(1,3) A(1,1) A(1,2)
      A(1,2) A(2,1) A(1,1)]

A3 = A(2:4, [1 3 4])

%% 1.3

clear
clc

B = diag(ones(1, 10)) + [0, ones(1,8), 0]' * [1, zeros(1,8), 1] + ...
    [1, zeros(1,8), 1]' * [0, ones(1,8), 0]

C = diag((1:200)) + diag(ones(1, 199), 1) + diag(ones(1, 199), -1) + ...
    diag(ones(1, 198) / 2, 2) + diag(ones(1, 198) / 2, -2)

D = diag(20:-2:2) + diag(ones(1, 8) / 2, -2) + diag(3.^(0:8), 1)

%% 1.4

clear
clc

x = (0:3);

f1 = @(x) x .* sin(x) + (1 / 2) .^ sqrt(x);
f1(x)

f2 = @(x) x .^ 4 + log(x .^ 3 + 1);
f2(x)

%% 1.5

clear
clc

x = (0:0.01:6);

f = @(x) 2 + (x - 3) .* sin(5 .* (x - 3));

plot(x, f(x))

hold on

plot(x, - x + 5, '--')
plot(x, x - 1, '--')
grid on

title('Grafico della funzione f(x)', 'Color', 'w')
legend('f(x)', 'retta1', 'retta2', 'Location', 'northeastoutside');

xlabel('Asse x')
ylabel('Asse y')

hold off

%% 1.6

clear
clc

x = (0.1:0.01:10);

f = @(x) (log(x)).^2;

semilogx(x, f(x))