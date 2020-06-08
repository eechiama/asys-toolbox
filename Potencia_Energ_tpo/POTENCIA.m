% POTENCIA -- Calcula la potencia promedio de una señal periódica en el dominio temporal.
%
%	p = POTENCIA(ft, T0, dt)
%
% Argumentos
% ==========
%
%	ft: vector de valores de 1 ciclo de la señal.
%	T0: período de la señal.
%	dt: paso temporal.
%
% Retorna
% =======
%
%	p: potencia promedio de la señal periódica.
%
% Detalle
% =======
%
% Para el caso de señales discretas utilizar dt=1.
%
function [p] = POTENCIA(ft,T0,dt)

p = (1/T0)*sum(abs(ft).^2)*dt;

end

