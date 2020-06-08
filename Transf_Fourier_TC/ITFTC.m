% ITFTC -- Transformada inversa de la Transformada de Fourier. (help TFTC)
%
%	[x,t] = ITFTC(w,Xw,tmax,dt)
%
% Argumentos
% ==========
%
%	w:	vector de frecuencia angular obtenido de la función 'TFTC'.
%	Xw:	vector de la transformada obtenido de la función 'TFTC'.
%	tmax:	tiempo máximo que se desea obtener de la reconstrucción.
%	dt:	paso temporal para el vector de tiempo de la reconstrucción.
%
% Retorna
% =======
%
%	x: señal reconstruída en el dominio temporal.
%	t: vector de tiempo.
%
% Detalle
% =======
%
% Se reconstruye en el intervalo temporal [-tmax, tmax].
%
function [x,t]=ITFTC(w,Xw,tmax,dt)

dw=w(2)-w(1);
t=-tmax:dt:(tmax);

centro = floor(length(t)/2)+1;% para negativos

x=zeros(size(t));
k=1;
for tt=t
x(k)=dw*sum(Xw.*exp(1i*tt*w)/(2*pi));
k=k+1;
end

x(centro)=sum(Xw)*dt;
x=real(x);