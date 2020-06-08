% SEF -- Calcula los coeficientes Cn y C0 de la Serie Exponencial de Fourier de una señal periódica.
%
%	Cn = SEF(t, ft, T0, N)
%
% Argumentos
% ==========
%
%	t:	vector de tiempo correspondiente a 1 ciclo de la señal.
%	ft:	vector de valores de 1 ciclo de la señal.
%	T0:	periódo de la señal.
%	N:	cantidad (Armónicas + Fundamental) de coeficientes a calcular.
%
% Retorna
% =======
%
%	Cn: coeficientes de la serie exponencial de fourier.
%
% Detalle
% =======
%
% El valor medio C0 se encuentra en el elemento C(N).
%
function [Cn]=SEF(t,ft,T0,N)
w0=2*pi/T0;
dt=t(2)-t(1);
Cn=zeros(1,2*N-1);
for n=-(N-1):(N-1)
Cn(n+N)=(1/T0)*sum(ft.*exp(-1i*w0*n*t))*dt;
end
Cn(N)=(1/T0)*sum(ft)*dt;