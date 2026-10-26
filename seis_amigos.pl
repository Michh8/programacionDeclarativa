% COMO PROBAR: en swipl, desde esta carpeta:
% consult('seis_amigos.pl').
% seis_amigos(M).
% Primera respuesta: M = [[carlos,tomas],[andres,dario],[alejandro,benito]].
% Las parejas corresponden a auto, avion y tren. Usa ; para otras respuestas.

% GUIA: consultar seis_amigos(MedTransp).
% Resultado: [[pasajeros_auto], [pasajeros_avion], [pasajeros_tren]].
% Cada medio tiene dos lugares. _ es una variable anonima distinta en cada uso.
% =/2 unifica la estructura; ==/2 compara identidad y \==/2 la rechaza.
% medio_transporte/3 coloca a cada amigo en un lugar por unificacion.
% El retroceso prueba otras ubicaciones si una restriccion falla.
% Puede haber soluciones equivalentes por intercambiar asientos de un medio.

% Seis amigos se van de vacaciones:

seis_amigos(MedTransp):-
	=(MedTransp, [Auto, Avion, Tren]),
        =(Auto, [_ , _]),
        =(Avion, [_ , _]),
        =(Tren, [_ , _]),
        medio_transporte(alejandro, MedioAle, MedTransp),
        \==(MedioAle, auto),
        medio_transporte(benito, MedioBen, MedTransp),
        \==(MedioBen, avion),
        ==(MedioAle, MedioBen),
        medio_transporte(andres, avion, MedTransp),
        medio_transporte(carlos, MedioCar, MedTransp),
        \==(MedioCar, avion),
        medio_transporte(dario, MedioDar, MedTransp),
        \==(MedioCar, MedioDar),
% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
        medio_transporte(tomas, _, MedTransp).


% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, auto, [[Amigo, _], _ , _]).
% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, auto, [[_, Amigo], _ , _]).

% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, avion, [_ , [Amigo, _], _]).
% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, avion, [_ , [_, Amigo], _]).

% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, tren, [_ , _ , [Amigo, _]]).
% Patron de lista: selecciona uno de los dos asientos del transporte indicado.
medio_transporte(Amigo, tren, [_ , _ , [_, Amigo]]).

