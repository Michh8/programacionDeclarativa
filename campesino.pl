% GUIA: ejecutar juego_campesino(EI). para buscar e imprimir recorridos.
% Cada estado es [Campesino, Zorra, Gallina, Granos], con lados izq y der.
% La busqueda prueba movimientos en orden y retrocede cuando una rama falla.
% not/1 significa negacion por fallo; member/2 detecta estados ya visitados.
% [Cabeza|Cola] agrega un estado al principio del historial.
% Las restricciones se conservan tal como vienen en el original.

% Problema del campesino:
juego_campesino(EI):-
	% Se asume el orden: campesino, zorra, gallina, granos.
	=(EI, [izq, izq, izq, izq]), % Estado inicial único.
	Estados = [EI], % Estructura de datos con historial de movimientos válidos.
	cruzar_rio(EI, Estados). % Invocar la cláusula recursiva.

% Caso base: todos llegaron; reverse/2 ordena el historial para imprimirlo.
cruzar_rio([der, der, der, der], Estados):-
	write('FIN DEL JUEGO'), nl, nl,
	reverse(Estados, Solucion),
	write(Solucion), nl, nl.

% Paso recursivo: mover, descartar prohibidos, guardar y seguir buscando.
cruzar_rio(Ubicacion, Estados):-
	trasladar(Ubicacion, UbicacionSig),
	not(prohibido(UbicacionSig)),
	guardar_estado(Estados, UbicacionSig, EstadosSig),
	cruzar_rio(UbicacionSig, EstadosSig).

% Evita ciclos: solo agrega estados que aun no aparecen en el historial.
guardar_estado(Estados, Ubicacion2, [Ubicacion2|Estados]):-
	not(member(Ubicacion2, Estados)).

% El orden en cada lista es: Campesino, Zorra, Gallina, Granos.
% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([izq, Zorra, Gallina, Granos], [der, Zorra, Gallina, Granos]).
% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([der, Zorra, Gallina, Granos], [izq, Zorra, Gallina, Granos]).

% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([izq, izq, Gallina, Granos], [der, der, Gallina, Granos]).
% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([der, der, Gallina, Granos], [izq, izq, Gallina, Granos]).

% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([izq, Zorra, izq, Granos], [der, Zorra, der, Granos]).
% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([der, Zorra, der, Granos], [izq, Zorra, izq, Granos]).

% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([izq, Zorra, Gallina, izq], [der, Zorra, Gallina, der]).
% Movimiento permitido: cambia de lado el campesino solo o con un acompanante.
trasladar([der, Zorra, Gallina, der], [izq, Zorra, Gallina, izq]).

% Restricciones:
prohibido([izq, der, der, izq]).
prohibido([der, izq, izq, der]).
prohibido([der, der, izq, izq]).
prohibido([izq, izq, der, der]).





