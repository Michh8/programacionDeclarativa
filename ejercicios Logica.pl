% COMO PROBAR: en swipl, desde esta carpeta:
% consult('ejercicios Logica.pl').
% Aparecera el error de sintaxis original del cine; los bloques anteriores
% quedan disponibles en SWI-Prolog. Cada ejercicio tiene su consulta abajo.
% Usa ; para pedir alternativas y Enter para aceptar una respuesta.

% GUIA: cada bloque representa un acertijo mediante candidatos y restricciones.
% =/2 unifica; =:=/2 compara valores numericos; =\=/2 exige valores diferentes.
% succ(A,B) relaciona enteros consecutivos B = A+1; no evalua expresiones.
% ADVERTENCIA ORIGINAL: succ(*(D2, 2), D1) causa error de tipo al alcanzarse.
% Ademas, succ(2*D2,D1) no expresa la formula alternativa del comentario.
% ADVERTENCIA ORIGINAL: sala_de_cine/1 tiene parentesis sin cerrar y usa suc/2.
% Ese bloque no se carga correctamente; suc/2 no esta definido en el archivo.
% No se corrigen estos problemas para preservar el programa entregado.
% Cargar este archivo puede mostrar errores aunque otras clausulas se carguen.

% Clave secreta:
% PRUEBA: clave_secreta(Clave).
% Esperado actualmente: error de tipo en succ/2; no se obtiene una clave.

% Genera digitos y filtra por las relaciones y la suma; ver advertencia inicial.
clave_secreta([D1, D2, D3, D4, D5]):-
    asignar_digito(D5),
    asignar_digito(D3),
    =:=(+(D5, D3), 14),
    asignar_digito(D2),
    asignar_digito(D4),
    succ(D2, D4), %=:=(D4, +(D2, 1)),
    asignar_digito(D1),
    succ(*(D2, 2), D1),%=:=(D1, -(*(D2, 2), 1)),
    =:=(+(D2, D3), 10),
    =:=(D1 + D2 + D3 + D4 + D5, 30).

% Dominio finito: el retroceso enumera los diez digitos mediante estos hechos.
asignar_digito(0).
asignar_digito(1).
asignar_digito(2).
asignar_digito(3).
asignar_digito(4).
asignar_digito(5).
asignar_digito(6).
asignar_digito(7).
asignar_digito(8).
asignar_digito(9).


% Tres senoras - sin lista:
% PRUEBA: tres_senoras_sin(Blanco, Rubio, Castano).
% Esperado: Blanco = rubio, Rubio = castano, Castano = blanco.

% Asigna colores y descarta coincidencias prohibidas y colores repetidos.
tres_senoras_sin(Blanco, Rubio, Castano):-
    color_cabello(Blanco),
    \==(Blanco, blanco),
    \==(Blanco, castano),
    color_cabello(Rubio),
    \==(Rubio, rubio),
    \==(Rubio, Blanco),
    color_cabello(Castano),
    \==(Castano, castano),
    \==(Castano, Blanco),
    \==(Castano, Rubio).


% Tres senoras - con lista:
% PRUEBA: tres_senoras(L).
% Esperado: L = [rubio,castano,blanco].

% Asigna colores y descarta coincidencias prohibidas y colores repetidos.
tres_senoras(L):-
    =(L, [Blanco, Rubio, Castano]),
    color_cabello(Blanco),
    \==(Blanco, blanco),
    \==(Blanco, castano),
    color_cabello(Rubio),
    \==(Rubio, rubio),
    \==(Rubio, Blanco),
    color_cabello(Castano),
    \==(Castano, castano),
    \==(Castano, Blanco),
    \==(Castano, Rubio).

color_cabello(blanco).
color_cabello(rubio).
color_cabello(castano).


% Hilera de cuatro casas:
% PRUEBA: hilera_de_casas(L).
% Primera respuesta: L = [[1,flores],[2,vasquez],[3,moreno],[4,gonzalez]].
% Usa ; para explorar otras distribuciones.

% Lista de [numero, apellido]; succ/2 en ambos sentidos comprueba vecindad.
hilera_de_casas(L):-
    =(L, [[1, _], [2, _], [3, _], [4, _]]),
    asignar_casa([V, vasquez], L),
    asignar_casa([M, moreno], L),
    (
        succ(V, M)
        ;
        succ(M, V)
    ),
    asignar_casa([G, gonzalez], L),
    (
        not(succ(V, G))
        ,
        not(succ(G, V))
    ),
    asignar_casa([F, flores], L),
    (
        not(succ(F, G))
        ,
        not(succ(G, F))
    ).

% Estas alternativas ubican una persona por unificacion en una posicion de la lista.
asignar_casa([1, X], [[1, X], _, _, _]).
asignar_casa([2, X], [_, [2, X], _, _]).
asignar_casa([3, X], [_, _, [3, X], _]).
asignar_casa([4, X], [_, _, _, [4, X]]).


% Edificio de cinco pisos:
% PRUEBA: cinco_plantas(L).
% Primera respuesta: L = [[1,marina],[2,canuta],[3,chilo],[4,mario],[5,lencha]].

% Lista de [piso, persona]; filtra extremos, vecinos y orden de altura.
cinco_plantas(L):-
    =(L, [[1, _], [2, _], [3, _], [4, _], [5, _]]),
    asignar_piso([Chilo, chilo], L),
    =\=(Chilo, 5),
    asignar_piso([Canuta, canuta], L),
    =\=(Canuta, 1),
    asignar_piso([Mario, mario], L),
    =\=(Mario, 5),
    =\=(Mario, 1),
    asignar_piso([Marina, marina], L),
    (
        not(succ(Mario, Marina))
        ,
        not(succ(Marina, Mario))
    ),
    (
        not(succ(Mario, Canuta))
        ,
        not(succ(Canuta, Mario))
    ),
    asignar_piso([Lencha, lencha], L),
    >(Lencha, Canuta).

% Estas alternativas ubican una persona por unificacion en una posicion de la lista.
asignar_piso([1, X], [[1, X], _, _, _, _]).
asignar_piso([2, X], [_, [2, X], _, _, _]).
asignar_piso([3, X], [_, _, [3, X], _, _]).
asignar_piso([4, X], [_, _, _, [4, X], _]).
asignar_piso([5, X], [_, _, _, _, [5, X]]).


% Sala de cine:
% PRUEBA PREVISTA: sala_de_cine(L).
% Actualmente no se puede resolver: la regla no se carga por su error de sintaxis.
% En una sesion nueva, la consulta reporta procedimiento sala_de_cine/1 desconocido.

% Intenta distribuir espectadores y comprobar vecinos; contiene errores originales.
sala_de_cine(L):-
    =(L, [[1, _], [2, _], [3, _], [4, borracho], [5, _], [6, _], [7, _], [8, _]]),
    is(Bo, 4),
    asignar_butaca([Ro, rosita], L),
    asignar_butaca([Ra, ramon], L),
    (
        succ(Ro, Ra)
        ;
        suc(Ra, Ro)
    ),
    (
        not(succ(Ro, Bo)
        ,
        not(suc(Bo, Ro))
    ),
    (
        not(succ(Ra, Bo)
        ,
        not(suc(Bo, Ra))
    ),
    asignar_butaca([To, tona], L),
    asignar_butaca([Ju, juanito], L),
    (
        succ(To, Ju)
        ;
        succ(Ju, To)
    ),
    asignar_butaca([An, anita], L),
    (
        succ(To, An)
        ;
        succ(An, To)
    ),
    asignar_butaca([Ma, mario], L).

% Estas alternativas ubican una persona por unificacion en una posicion de la lista.
asignar_butaca([1, X], [[1, X], _, _, _, _, _, _, _]).
asignar_butaca([2, X], [_, [2, X], _, _, _, _, _, _]).
asignar_butaca([3, X], [_, _, [3, X], _, _, _, _, _]).
asignar_butaca([4, X], [_, _, _, [4, X], _, _, _, _]).
asignar_butaca([5, X], [_, _, _, _, [5, X], _, _, _]).
asignar_butaca([6, X], [_, _, _, _, _, [6, X], _, _]).
asignar_butaca([7, X], [_, _, _, _, _, _, [7, X], _]).
asignar_butaca([8, X], [_, _, _, _, _, _, _, [8, X]]).

