% ENERGIA -- Calcula la energía de una señal aperiódica en el dominio temporal.
%
%	e = ENERGIA(ft, dt)
%
% Argumentos
% ==========
%
%	ft: señal aperíodica.
%	dt: paso temporal.
%
% Retorna
% =======
%
%	e: energía de la señal aperiódica.
%
% Detalle
% =======
%
% Para el caso de señales discretas utilizar dt=1.
%
function [e] = ENERGIA(ft, dt)

e = sum(abs(ft).^2)*dt;

end

