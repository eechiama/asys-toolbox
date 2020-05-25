function [Xw w]=DFT(n,xn)
% DFT -- Calcula la transformada discreta de fourier.
% 
% Uso:
%   [Xw w] = DFT(n, xn)
%
% * Argumentos *
%       n: vector de tiempos.
%      xn: vector de valores a transformar.
%
% * Retorna *
%      Xw: vector de la transformada.
%       w: vector de frecuencia angular.
%
% * Ejemplo básico *
% n = -20 : 20;
% xn = escalon(n+4) - escalon(n-4);
% [Xw w] = DFT(n, xn);
%
% subplot(311); stem(n, xn); axis tight; grid on;
% xlabel('muestras','fontsize',17); ylabel('x[n]','fontsize',17); 
%
% subplot(312); stem(w, abs(Xw) ); axis tight; grid on;
% xlabel('k . \Omega_0','fontsize',17);
% ylabel('| C_k |', 'fontsize', 17);
%
% subplot(313); stem(w, angle(Xw) ); axis tight; grid on;
% xlabel('k . \Omega_0','fontsize',17);
% ylabel('\phi(C_k)', 'fontsize', 17');
N0=length(xn);
w0=2*pi/N0;
w=(0:N0-1)*w0;
Xw=zeros(size(w));
k=1;
for ww=w
Xw(k)=sum(xn.*exp(-1i*ww*n));
k=k+1;
end
Xw(1)=sum(xn);
Xw=Xw/N0;
