clear
close
clc

N = 1e6;
M = 0;

for i=1:N
    punto = rand(1, 2);

    if punto(1)^2 + punto(2)^2 <= 1
        M = M + 1;
    end
end

S_N = 4 * M / N