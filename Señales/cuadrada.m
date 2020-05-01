function [xt, t] = cuadrada(T0,ciclos,dt,forma)

if nargin == 3
	forma = 'derecha';
end

if !strcmp(forma,'derecha')
	ciclos_der = floor(ciclos/2);
	ciclos_izq = ciclos_der + mod(ciclos,2);
	if forma(end)=='+'
		aux = ciclos_izq;
		ciclos_izq = ciclos_der;
		ciclos_der = aux;
	end
	nizq = -ciclos_izq;
	nder = ciclos_der;
	t = -ciclos_izq*T0 : dt : ciclos_der*T0 - dt;
else
	t = 0 : dt : (ciclos*T0) - dt;
	nizq = 0;
	nder = ciclos;
end

xt = 0;
for n = nizq:nder;
	xt = xt + escalon(t-n*T0) - 2*escalon(t-(n+1/2)*T0) + escalon(t-(n+1)*T0);
end

end
