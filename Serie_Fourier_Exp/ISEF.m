% ISEF -- Transformada inversa de la Serie Exponencial de Fourier.
%
%	ft = ISEF(t, Cn, T0)
%
% Argumentos
% ==========
%
%	t:	vector de tiempo correspondiente a 1 ciclo de la señal.
%	Cn:	coeficientes de la serie exponencial de fourier. (help SEF)
%	T0:	periódo de la señal.
%
% Retorna
% =======
%
%	ft: señal reconstruída en el dominio temporal.
%
function [ft]=ISEF(t,Cn,T0)
w0=2*pi/T0;
N=floor(length(Cn)/2)+1;
ft=zeros(size(t));
for n=-(N-1):(N-1)
ft=ft+Cn(n+N).*exp(1i*w0*n*t);
end
ft=real(ft);