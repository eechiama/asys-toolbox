% ENERGIA_TFTC -- Calcula la energía del espectro de la Transformada de Fourier.
%
%	[e] = ENERGIA_TFTC(Xw, dw)
%
% Argumentos
% ==========
%
%	Xw: vector de la Transformada de Fourier. (help TFTC)
%	dw: paso frecuencial.
%
% Retorna
% =======
%
%	e: energía del espectro.
%
% Detalle
% =======
% 
% Al ser la identidad de Parseval, también es válida para el espectro de la TFTD.
% Algunas consideraciones para dicho caso:
%
% - El espectro de la TFTD es periódico, considerar la cantidad de ciclos obtenidos
% al utilizar la función 'TFTD'.
%
% - Debería utilizarse dw=0.001, como lo hace internamente la función 'TFTD'.
%
%
% Ejemplo básico
% ==============
%
% t = -5 : 0.01 : 5;
% ft = escalon(t+2) - escalon(t-2);
% [Fw, w] = TFTC(t,ft, 2*pi*10, 0.01);
% e = ENERGIA_TFTC(Fw, 0.01);
%
% subplot(311); plot(t, ft); grid on; axis tight; ylim([0 1.2]);
% xlabel('t [seg]', 'fontsize', 17); ylabel('f(t)', 'fontsize', 17);
%
% subplot(312); plot(w/(2*pi),abs(Fw)); grid on; axis tight;
% xlabel('f [Hz]', 'fontsize', 17); ylabel('| F(w) |', 'fontsize', 17);
%
% subplot(313); stem(p, 'filled'); grid on; axis tight;
% xlabel('Energía', 'fontsize', 17);
% e
%
function [e] = ENERGIA_TFTC(Xw, dw)
e = (1/(2*pi))*sum(abs(Xw).^2)*dw;
end