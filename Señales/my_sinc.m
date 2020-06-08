% my_sinc -- Genera función sinc con frecuencia angular requerida.
%
%	ft = my_sinc(t, w)
%
% Argumentos
% ==========
%
%	t: vector de valores del dominio temporal.
%	w: frecuencia angular requerida para la sinc.
%
% Retorna
% =======
%
%	ft: vector de valores de la función sinc requerida
%
% Detalle
% =======
%
% Notar que en el límite t -> 0 resulta f(t) = 1.
%
function ft = my_sinc(t, w)
  ft = sin(w*t)./(w*t);
  inx_nan = find(isnan(ft));
  ft(inx_nan) = 1;
end
