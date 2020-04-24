% coeff_bn -- Calcula los coeficiences 'bn' de la Serie Trigonométrica
%             de Fourier, para una señal periódica.
%
% Uso:
%   bn = coeff_bn( N, t, ft )
%
% * Argumentos *
%     N: cantidad de coeficientes a calcular.
%     t: vector de tiempo correspondiente a 1 ciclo de la señal.
%    ft: vector de valores de 1 ciclo de la señal.
%
% * Retorna *
%    bn: coeficientes an
function bn = coeff_bn(N, t, F)
  
  T0 = t(end)-t(1);
  dt = t(2) - t(1);
  
  w0 = 2*pi/T0;
  
  for i=1:N
    bn(i) = (2 / T0) * sum( F .* sin(i*w0.*t) ) * dt;
  end
  
end