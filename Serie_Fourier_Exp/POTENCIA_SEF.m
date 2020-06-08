% POTENCIA_SEF -- Calcula la potencia promedio de una señal periódica continua
%		  a partir de los coeficientes de su Serie Exponencial de Fourier.
%
%	p = POTENCIA_SEF(Cn)
%
% Argumentos
% ==========
%
%	Cn:	coeficientes de la serie exponencial de fourier. (help SEF)
%
% Retorna
% =======
%
%	p:	potencia promedio de la señal periódica.
%
function [p] = POTENCIA_SEF(Cn)

p=sum(abs(Cn).^2);

end