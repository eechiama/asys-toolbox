% TFTC -- Calcula la transformada continua de fourier.
%
%	[Fw, w] = TFTC(t,ft,wmax,dw)
%
% Argumentos
% ==========
%
%	t:	vector de tiempos.
%	ft:	vector de valores a transformar.
%	wmax:	frecuencia angular (w) máxima a calcular.
%	dw:	paso frecuencial.
%
% Retorna
% =======
%
%	Fw:	vector de la transformada.
%	w:	vector de frecuencia angular.
%
% Detalle
% =======
%
% Si se utiliza un 'wmax' lo suficientemente grande
% puede apreciarse que el espectro es periódico. A qué se debe esto?
%
% Ejemplo básico
% ==============
%
% t = -5 : 0.01 : 5;
% ft = escalon(t+2) - escalon(t-2);
% [Fw,w] = TFTC(t,ft, 2*pi*10, 0.01);
%
% subplot(311); plot(t, ft); grid on; axis tight; ylim([0 1.2]);
% xlabel('t [s]', 'fontsize', 17); ylabel('f(t)', 'fontsize', 17);
%
% subplot(312); plot(w/(2*pi),abs(Fw)); grid on; axis tight;
% xlabel('f [Hz]', 'fontsize', 17); ylabel('|F(w)|', 'fontsize', 17);
%
% subplot(313); plot(w/(2*pi),angle(Fw)); grid on; axis tight;
% xlabel('f [Hz]', 'fontsize', 17); ylabel('\phi(F(w))', 'fontsize', 17');
%
function [Fw w]=TFTC(t,ft,wmax,dw)
dt=t(2)-t(1);
w=-(wmax):dw:(wmax);
centro=floor(length(w)/2)+1;
Fw=zeros(size(w));
k=1;
for ww=w
Fw(k)=dt*sum(ft.*exp(-1i*ww*t));
k=k+1;
end
Fw(centro)=sum(ft)*dt;