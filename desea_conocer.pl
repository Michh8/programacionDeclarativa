% Transcripcion de las tres versiones de la imagen proporcionada.
% Requieren hechos conoce/2: conoce(ana, bea). conoce(bea, carlos).
% Esos hechos se pueden ingresar con assertz/1 para probar, sin editar este archivo.
% Se conserva la logica de la imagen, incluso sus limitaciones.

% Version 1: caso directo; imprime Y y corta las alternativas de esta llamada.
desea_conocer_v1(X, Y):-
    conoce(X, Y),
    writeln(Y),
    !.

% Caso indirecto: busca un intermediario Z y continua desde el.
% Imprime Z al volver de la recursion; no controla ciclos.
desea_conocer_v1(X, Y):-
    conoce(X, Z),
    desea_conocer_v1(Z, Y),
    writeln(Z).

% Version 2: guarda visitados en la base dinamica con eslabon/1.
% abolish/2 elimina el predicado previo; assert/1 inserta hechos.
% Estos cambios de la base de datos no se deshacen con el retroceso.
desea_conocer_v2(X, Y):-
    abolish(eslabon, 1),
    assert(eslabon(X)),
    desea_conocer_v2_rec(X, Y).

% Si existe conexion directa, registra el destino y termina esta llamada.
desea_conocer_v2_rec(X, Y):-
    conoce(X, Y),
    assert(eslabon(Y)),
    !.

% Esta clausula falla si encuentra un vecino visitado; Prolog puede probar
% la siguiente clausula. fail/0 por si solo no corta todas las alternativas.
desea_conocer_v2_rec(X, _):-
    conoce(X, Z),
    eslabon(Z),
    fail.

% Avanza solo por vecinos no registrados y los conserva entre ramas.
desea_conocer_v2_rec(X, Y):-
    conoce(X, Z),
    not(eslabon(Z)),
    assert(eslabon(Z)),
    desea_conocer_v2_rec(Z, Y),
    !.

% Version 3: pasa el historial como lista en vez de modificar la base.
% W queda en orden inverso: destino, intermediarios, origen.
desea_conocer_v3(X, Y, W):-
    desea_conocer_v3_rec(X, Y, [], L),
    append(L, [X], W).

% Caso directo: agrega el destino al principio del historial acumulado.
desea_conocer_v3_rec(X, Y, L, Lfin):-
    conoce(X, Y),
    =(Lfin, [Y|L]),
    !.

% Falla para un vecino ya incluido; el filtro efectivo esta en la regla siguiente.
desea_conocer_v3_rec(X, _, L, _):-
    conoce(X, Z),
    member(Z, L),
    fail.

% Agrega un vecino no visitado y propaga la lista que devuelve la recursion.
% Como en la imagen, el corte final esta comentado y el origen no inicia en L.
desea_conocer_v3_rec(X, Y, L, Lfin):-
    conoce(X, Z),
    not(member(Z, L)),
    =(Ltemp, [Z|L]),
    desea_conocer_v3_rec(Z, Y, Ltemp, LfinAux),
    =(Lfin, LfinAux).
    %!.
