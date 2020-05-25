function [Xw w]=TFTD(n,xn, ciclos)  
% TFTD -- Calcula la transformada de fourier en tiempo discreto.
% 
% Uso:
%   [Xw w] = TFTD(n, xn)
%   [Xw w] = TFTD(n, xn, ciclos)
%
% * Argumentos *
%       n: vector de tiempos.
%      xn: vector de valores a transformar.
%  ciclos: (opcional) cantidad de períodos a calcular del espectro.
%          Si no se especifica, por defecto se calcula 1 solo período. 
%
% * Retorna *
%  Xw: vector de la transformada.
%   w: vector de frecuencia angular.
%
% * Ejemplo básico *
% n = -20 : 20;
% xn = escalon(n+4) - escalon(n-4);
% [Xw w] = TFTD(n, xn, 3);
%
% subplot(311); stem(n, xn); axis tight; grid on;
% xlabel('muestras','fontsize',17); ylabel('x[n]','fontsize',17); 
%
% subplot(312); plot(w, abs(Xw) ); axis tight; grid on;
% xlabel('\Omega','fontsize',17);
% ylabel('| F(\Omega) |', 'fontsize', 17);
%
% subplot(313); plot(w, angle(Xw) ); axis tight; grid on;
% xlabel('\Omega','fontsize',17);
% ylabel('\phi(X(\Omega))', 'fontsize', 17');

if nargin == 2
   ciclos = 1;
elseif nargin > 3 || nargin < 2
   error('Se requieren 2 o 3 argumentos.');
end

wmax=pi*ciclos;
dw=0.001;
w=-(wmax):dw:(wmax);
centro = floor(length(w)/2)+1;
Xw=zeros(size(w));
k=1;
for ww=w
Xw(k)=sum(xn.*exp(-1i*ww*n));
k=k+1;
end
Xw(centro)=sum(xn);
