% ISTF -- Transformada inversa de la Serie Trigonométrica de Fourier.
%
%	serie = ISTF(N, t, a0, an, bn, T0)
%
% Argumentos
% ==========
%
%	N:	cantidad de coeficientes a calcular.
%	t:	vector de tiempos correspondiente al tiempo que
%		querramos reconstruír de la señal.
%	a0:	coeficiente obtenido de la función 'STF_a0'.
%	an:	coeficientes obtenidos de la función 'STF_an'.
%	bn:	coeficientes obtenidos de la función 'STF_bn'.
%	T0:	período de la señal original.
%
% Retorna
% =======
%
%	serie: vector de valores de la Serie Trigonométrica de Fourier
%
function serie = ISTF( N, t, a0, an, bn, T0)
  
%  T0 = t(end)-t(1);
%  Mejor que lo defina el usuario:
%  El argumento t es el tiempo que se reconstruye, que puede ser mayor a 1 ciclo.
  
  w0 = 2*pi/T0;
  
  serie = zeros( size(t) );

  for i=1:N
    serie = serie + an(i) .* cos(i*w0*t) + bn(i) .* sin(i*w0*t);
  end

  serie = serie + a0/2;

end