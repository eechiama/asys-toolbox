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
% asumo que la DFT de 1 ciclo de la señal periódica de N0 muestras es
% también de N0 muestras.
N0=length(Xk);
p=(1/(N0^2))*sum(abs(Xk).^2);
end
