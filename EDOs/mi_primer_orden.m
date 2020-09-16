function [ dy ] = mi_segundo_orden( t,y,ft)

ft = ft(t);     % Apunto el puntero a función evaluado en el t que corresponda

dy = -5*y + ft;

end

