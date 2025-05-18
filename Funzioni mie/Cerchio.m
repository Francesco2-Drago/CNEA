%% Metodo brutale per fare cerchio

clear
clc

x = (-1:0.01:1);

cerchio = @(x) 1 - x .^ 2;

plot(x, sqrt(cerchio(x)))

hold on

plot(x, -sqrt(cerchio(x)))

title('Grafico di un cerchio')

grid on

axis equal

hold off

%% Metodo corretto per fare un cerchio (parametrizzazione)

clear
clc

theta = (-1:0.1:2*pi);

radiius = 1;

xOrigin = 0;
yOrigin = 0;

x = radiius * cos(theta) + xOrigin;
y = radiius * sin(theta) + yOrigin;

plot(x, y)

legend('Cerchio $$ x^2+y^2=1 $$', 'interpreter', 'latex', 'Location', ...
    'northeastoutside')

grid on

axis equal