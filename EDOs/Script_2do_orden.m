%% Segundo orden
clc,clear, close all

dt = 0.1;
t = 0:dt:8;
CI = [0; 0];    % OJO: Depende de como se haya definido la ecuación 
                % diferencial, el primer parámetro puede ser posición o 
                % velocidad. En este caso es primero posición y dsp
                % velocidad.
                
x = @(t) u(t);  % Excitación de la EDO, se define como un puntero a función 
                % que depende de t

[t_ode, Y] = ode45(@(t,y) mi_segundo_orden(t,y,x), t, CI);

%Y tiene n cantidad de filas, pero dos columnas. Por como está definida la
%ecuación diferencial en la función "mi_segundo_orden", la primer columna
%es la posición angular y segunda columna, la velocidad angular.


plot(t,Y(1:end,1), t, Y(1:end,2), 'linewidth',2)
grid on
legend('\theta (t)','\omega (t)')
