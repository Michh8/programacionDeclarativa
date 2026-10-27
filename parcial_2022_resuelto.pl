% Solucion del parcial de la imagen (ciclo 02/2022).
% Cargar en SWI-Prolog: consult('parcial_2022_resuelto.pl').
% Cada ejercicio incluye consultas de prueba. No es necesario cargar otros archivos.

% EJERCICIO 1: ruta de busqueda en un arbol binario de busqueda.
% Representacion: nodo(Valor, Izquierdo, Derecho); nulo es un arbol vacio.
% Se asume un arbol ordenado y un numero de busqueda ya conocido.
% La ruta incluye los nodos examinados, incluso si el numero no existe.
% PRUEBAS:
% arbol_ejemplo(A), aridad_3(A, 4, L).     L = [5,3,4].
% arbol_ejemplo(A), aridad_3(A, 6, L).     L = [5,9].
% arbol_ejemplo(A), aridad_3(A, 5, L).     L = [5].
% aridad_3(nulo, 6, L).                   L = [].

arbol_ejemplo(
    nodo(5,
        nodo(3, nodo(1, nulo, nulo), nodo(4, nulo, nulo)),
        nodo(9, nulo, nodo(11, nulo, nulo)))
).

% Predicado de aridad 3: arbol, numero buscado y lista resultante.
aridad_3(Arbol, Numero, Ruta):-
    ruta_busqueda(Arbol, Numero, Ruta).

% Si se llega a un hijo vacio, no hay mas nodos que agregar.
ruta_busqueda(nulo, _, []).
% Si coincide, se incluye el nodo y la busqueda termina.
ruta_busqueda(nodo(Valor, _, _), Numero, [Valor]):-
    Numero =:= Valor.
% Un numero menor solo puede estar en el subarbol izquierdo.
ruta_busqueda(nodo(Valor, Izquierdo, _), Numero, [Valor|Ruta]):-
    Numero < Valor,
    ruta_busqueda(Izquierdo, Numero, Ruta).
% Un numero mayor solo puede estar en el subarbol derecho.
ruta_busqueda(nodo(Valor, _, Derecho), Numero, [Valor|Ruta]):-
    Numero > Valor,
    ruta_busqueda(Derecho, Numero, Ruta).

% EJERCICIO 2: derivacion simbolica con regla de la cadena.
% La imagen dice "arco tangente", pero escribe acos(g(x)) y la formula
% -g'(x)/sqrt(1-g(x)^2), que corresponde al ARCO COSENO.
% Se implementan ambos: acos(G) para la formula y atan(G) para arco tangente.
% Se usa x (atomo) como variable matematica, no X libre de Prolog.
% derivada(Variable, Expresion, Resultado) devuelve un termino sin simplificar.
% PRUEBAS:
% derivada(x, 7, D).                   D = 0.
% derivada(x, x, D).                   D = 1.
% derivada(x, 3*x^2+x+1, D).
% derivada(x, acos(x^2), D).
% Resultado: D = -(2*x^1*1)/sqrt(1-(x^2)^2).
% derivada(x, atan(x^2), D).
% Resultado: D = 2*x^1*1/(1+(x^2)^2).
% Para comprobar numericamente en x=2 (arco tangente):
% derivada(x, atan(x^2), D), evaluar(D, x, 2, Valor).
% Valor esperado: aproximadamente 0.23529411764705882 (4/17).
% Para acos se requiere -1 < g(x) < 1 al evaluar esta formula real.

% Una constante numerica deriva a cero; la variable respecto a si misma, a uno.
derivada(_, N, 0):- number(N).
derivada(X, X, 1):- atom(X).
% La suma y la resta se derivan termino a termino.
derivada(X, F+G, DF+DG):-
    derivada(X, F, DF), derivada(X, G, DG).
derivada(X, F-G, DF-DG):-
    derivada(X, F, DF), derivada(X, G, DG).
derivada(X, -F, -DF):- derivada(X, F, DF).
% Regla del producto: (F*G)' = F'*G + F*G'.
% Cubre tambien una constante multiplicada por x o por una potencia.
derivada(X, F*G, DF*G+F*DG):-
    derivada(X, F, DF), derivada(X, G, DG).
% Potencia de exponente numerico y regla de la cadena.
% Se separa exponente cero para no generar 0*F^(-1) en su derivada.
derivada(_, _^N, 0):- number(N), N =:= 0.
derivada(X, F^N, N*F^M*DF):-
    number(N), N =\= 0, M is N-1,
    derivada(X, F, DF).
derivada(X, acos(G), -DG/sqrt(1-G^2)):-
    derivada(X, G, DG).
derivada(X, atan(G), DG/(1+G^2)):-
    derivada(X, G, DG).

% Evaluacion opcional: sustituye el atomo x por un numero sin modificar D.
evaluar(Expresion, Variable, Valor, Resultado):-
    sustituir(Expresion, Variable, Valor, Numerica),
    Resultado is Numerica.

sustituir(Termino, Variable, Valor, Resultado):-
    ( Termino == Variable -> Resultado = Valor
    ; atomic(Termino) -> Resultado = Termino
    ; Termino =.. [Funcion|Argumentos],
      sustituir_argumentos(Argumentos, Variable, Valor, Nuevos),
      Resultado =.. [Funcion|Nuevos]
    ).

sustituir_argumentos([], _, _, []).
sustituir_argumentos([A|As], Variable, Valor, [B|Bs]):-
    sustituir(A, Variable, Valor, B),
    sustituir_argumentos(As, Variable, Valor, Bs).

% EJERCICIO 3: familia en una barra de seis puestos.
% Convencion: la lista va de izquierda a derecha; derecha significa mayor indice.
% Miembros: mama, papa, abuela, sarita, karina y jaimito.
% La abuela es la suegra de papa. Su nieto varon es jaimito.
% "A la par" y "junto" significan asientos consecutivos.
% PRUEBA: familia(Barra). Usa ; para pedir todas las respuestas.
% PRUEBA PARA REUNIRLAS: findall(B, familia(B), Soluciones).
% Hay seis soluciones ("a su derecha" no exige estar inmediatamente al lado):
% [abuela,sarita,mama,papa,karina,jaimito]
% [abuela,sarita,mama,papa,jaimito,karina]
% [sarita,papa,mama,abuela,karina,jaimito]
% [sarita,papa,mama,abuela,jaimito,karina]
% [sarita,abuela,mama,papa,karina,jaimito]
% [sarita,abuela,mama,papa,jaimito,karina]

familia(Barra):-
    % Una permutacion ocupa cada asiento con una persona distinta.
    permutation([mama,papa,abuela,sarita,karina,jaimito], Barra),
    nth1(3, Barra, mama),
    nth1(Papa, Barra, papa),
    vecinos(Papa, 3),
    nth1(Abuela, Barra, abuela),
    nth1(Jaimito, Barra, jaimito),
    Abuela < Jaimito,
    not(vecinos(Papa, Abuela)),
    nth1(Sarita, Barra, sarita),
    nth1(Karina, Barra, karina),
    not(vecinos(Sarita, Karina)),
    vecinos(Jaimito, Karina).

% Ambos indices ya son numeros al comprobar su distancia.
vecinos(A, B):- 1 =:= abs(A-B).
