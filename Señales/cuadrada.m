% cuadrada -- Genera una señal cuadrada y su vector de tiempo correspondiente.
%
%	ft = cuadrada(T0, ciclos, dt)
%	ft = cuadrada(T0, ciclos, dt, start)
%
% Argumentos
% ==========
%
%	T0:	período deseado de la señal generada.
%	ciclos: ciclos deseados de la señal generada.
%	dt:	paso temporal para el vector de tiempos.
%	start:	determina en qué valores de tiempo comienza la señal.
%
% Retorna
% =======
%
%	xt:	vector de valores de la señal generada.
%	t:	vector temporal generado.
%
% Detalle
% =======
%
% El 4to argumento ('start') es opcional. Sus posibles valores son:
%
%	'cero': comienza en t=0. (default)
%	
%	'neg+': comienza en valores de tiempo negativos.
%		si 'ciclos' es impar, habrá un ciclo más en tiempos positivos.
%
%	'neg-': comienza en valores negativos.
%		si 'ciclos' es impar, habrá un ciclo más en tiempos negativos.
%
% Si la cantidad de ciclos especificada es un número entero entonces en t=0 siempre se dará el
% comienzo de un nuevo ciclo. Esto es sin importar qué valor de 'start' se haya especificado.
%
% Si la cantidad de ciclos especificada no es un número entero, entonces ya no necesariamente
% en t=0 comenzará un ciclo.
%
function [xt, t] = cuadrada(T0,ciclos,dt,start)

if nargin == 3
	start = 'cero';
end

if !strcmp(start,'cero')
	ciclos_der = floor(ciclos/2);
	ciclos_izq = ciclos_der + mod(ciclos,2);
	if start(end)=='+'
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
