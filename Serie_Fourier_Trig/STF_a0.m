% STF_a0 -- Calcula el coeficiente 'a0' de la Serie Trigonométrica de Fourier
%		de una señal periódica.
%
%	a0 = STF_a0(t, ft)
%
% Argumentos
% ==========
%
%	t:	vector de tiempo correspondiente a 1 ciclo de la señal.
%	ft:	vector de valores de 1 ciclo de la señal.
%
% Retorna
% =======
%
%	a0: coeficiente a0 de la STF.
%   
function a0 = STF_a0(t, ft)
  
  T0 = t(end)-t(1);
  
  dt = t(2)-t(1);
  
  a0 =  ( 2 / T0 ) * sum( ft ) * dt ;

end
