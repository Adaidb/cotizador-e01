:- consult(variante).

% cotizar(+Embarque, -Resultado)
cotizar(E, error(Id, Motivo)) :-
    E = embarque(Id, _, _, _, _, _, _),
    once(rechazo(E, Motivo)), !.
cotizar(E, ok(Id, C)) :-
    E = embarque(Id, _, _, _, _, _, _),
    \+ rechazo(E, _),
    calcular(E, C).

% rechazo(+Embarque, -Motivo): una clausula por motivo, en orden
rechazo(embarque(_, Peso, _, _, _, _, _), peso_invalido) :-
    Peso =< 0.
rechazo(embarque(_, _, Dist, _, _, _, _), distancia_invalida) :-
    Dist =< 0.
rechazo(embarque(_, _, _, Tipo, _, _, _), tipo_desconocido) :-
    \+ recargo(Tipo, _, _).
rechazo(embarque(_, _, _, _, Puente, _, _), puente_desconocido) :-
    \+ cuota_puente(Puente, _).
rechazo(embarque(_, _, _, peligrosa, _, none, _), falta_numero_un).
rechazo(embarque(_, _, _, sobredimensionada, _, _, none), falta_permiso).
rechazo(embarque(_, Peso, _, Tipo, _, _, _), excede_peso_maximo) :-
    Tipo \== sobredimensionada,
    peso_maximo(Max),
    Peso > Max.

% pct(+Monto, +Porcentaje, -Resultado): redondeo entero
pct(Monto, P, R) :-
    R is (Monto * P + 50) // 100.

% aplica_descuento(+Peso): segun criterio de variante.pl
aplica_descuento(Peso) :-
    descuento(Umbral, _, a_partir_de),
    Peso >= Umbral.
aplica_descuento(Peso) :-
    descuento(Umbral, _, mas_de),
    Peso > Umbral.

% monto_descuento(+Peso, +Bruto, -Desc): corte para evitar segunda respuesta
monto_descuento(Peso, Bruto, D) :-
    aplica_descuento(Peso), !,
    descuento(_, P, _),
    pct(Bruto, P, D).
monto_descuento(_, _, 0).

% calcular(+Embarque, -Cotizacion): etapa 2 (recargo y ajuste minimo en 0)
calcular(embarque(_, Peso, Dist, _, Puente, _, _), cotizacion(Bruto, Desc, Flete, Cuota, 0, 0, Total)) :-
    tarifa_km(Tarifa),
    Bruto is Dist * Tarifa,
    monto_descuento(Peso, Bruto, Desc),
    Flete is Bruto - Desc,
    cuota_puente(Puente, Cuota),
    Total is Flete + Cuota.