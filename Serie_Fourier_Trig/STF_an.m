% STF_an -- Calcula los coeficiences 'an' de la Serie Trigonométrica de Fourier
%		de una señal periódica.
%
%	an = STF_an(N, t, ft)
%
% Argumentos
% ==========
%
%	N:	cantidad de coeficientes a calcular.
%	t:	vector de tiempo correspondiente a 1 ciclo de la señal.
%	ft:	vector de valores de 1 ciclo de la señal.
%
% Retorna
% =======
%
%	an: coeficientes an de la STF.
%
function an = STF_an(N, t, ft)
  
  T0 = t(end)-t(1);
  dt = t(2) - t(1);
  
  w0 = 2*pi/T0;
  
  for i=1:N
    an(i) =  ( 2 / T0 ) * sum( ft .* cos(i*w0.*t) ) * dt;
  end
 
end
