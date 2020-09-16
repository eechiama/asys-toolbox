%% Segundo orden
clc,clear, close all

dt = 0.1;
t = 0:dt:8;
CI = [0]; 
                
x = @(t) u(t);  % Excitación de la EDO, se define como un puntero a función 
                % que depende de t

[t_ode, Y] = ode45(@(t,y) mi_primer_orden(t,y,x), t, CI);

plot(t,Y, 'linewidth',2)
grid on
legend('\theta (t)')
