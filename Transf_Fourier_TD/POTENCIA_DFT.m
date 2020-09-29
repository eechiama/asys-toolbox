% POTENCIA_DFT -- Calcula la potencia promedio de una señal periódica y discreta
%		  a partir de los coeficientes de su Transformada Discreta de Fourier.
%
%	p = POTENCIA_DFT(Xk)
%
% Argumentos
% ==========
%
%	Xk:	coeficientes correspondientes a 1 ciclo del espectro
%		de la Transformada Discreta de Fourier. (help DFT)
%
% Retorna
% =======
%
%	p:	potencia promedio de la señal periódica.
%
function [p] = POTENCIA_DFT(Xk)
p=sum(abs(Xk).^2);
end
