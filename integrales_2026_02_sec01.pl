% COMO PROBAR: en swipl, desde esta carpeta:
% consult('integrales_2026_02_sec01.pl').
% Ejecuta las consultas indicadas antes de cada regla.

% GUIA: s(Variable, Expresion, Integral) construye una primitiva simbolica.
% Ejemplo: s(x, x^2, I). produce I = 1/3*x^3.
% atomic/1 comprueba un termino atomico; number/1 exige un numero.
% is(M, +(N,1)) calcula M = N+1; ! evita intentar otras reglas.
% var/1 permite la variante con variable sin instanciar: s(X, X^2, I).
% Limitaciones originales: no agrega constante C, no simplifica ni trata N = -1.
% No se implementan integrales de sumas ni de otras funciones.

% Integral de una constante:

% PRUEBA: s(x, 5, I). Resultado esperado: I = 5*x.
s(Var, K, K*Var):-
    atomic(Var), number(K), !.


% Integral de una variable respecto a sí misma:

% PRUEBA: s(x, x, I). Resultado esperado: I = 1/2*x^2.
s(Var, Var, 1/2*Var^2):-
    atomic(Var), !.



% Integral de una variable elevada a la N:

% PRUEBA: s(x, x^2, I). Resultado esperado: I = 1/3*x^3.
s(Var, Var^N, 1/M*Var^M):-
    atomic(Var), number(N), is(M, +(N,1)), !.


% Integral de una constante por una variable elevada a la N:

% PRUEBA: s(x, 4*x^2, I). Resultado esperado: I = 4/3*x^3.
s(Var, K*Var^N, K/M*Var^M):-
    atomic(Var), number(K), number(N), is(M, +(N,1)), !.


% INTEGRALES PARA EVALUACION:

% Integral de una variable elevada a la N:

% PRUEBA (X libre): s(X, X^2, I). Resultado: I = 1/3*X^3.
s(Var, Var^N, 1/M*Var^M):-
    var(Var), number(N), is(M, +(N,1)), !.
