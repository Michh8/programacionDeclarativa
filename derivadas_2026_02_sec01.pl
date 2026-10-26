% COMO PROBAR: abre swipl en esta carpeta y escribe:
% consult('derivadas_2026_02_sec01.pl').
% Copia las consultas de cada regla sin el signo de comentario %.
% Las respuestas son expresiones simbolicas, sin simplificacion automatica.

% GUIA: d(Variable, Expresion, Derivada) construye una derivada simbolica.
% Ejemplo: d(x, x^3, D). produce D = 3*x^2.
% atomic/1 acepta atomos y numeros; var/1 comprueba que algo no esta instanciado.
% ==/2 compara identidad sin asignar; is/2 evalua aritmetica a su derecha.
% ! (corte) descarta alternativas de la llamada actual: importa el orden de reglas.
% Las expresiones resultantes son terminos: no se simplifican automaticamente.
% En la segunda seccion se usa una variable Prolog: d(X, X^3, D).
% Se conservan las reglas originales, con sus limites de reconocimiento.

% DERIVADAS PLENAMENTE SIMBOLICS:

% Derivada de una constante:

% PRUEBA: d(x, 5, D). Resultado esperado: D = 0.
d(Var, Exp1, 0):-
    atomic(Var), number(Exp1),  !.


% Derivara de una variable respecto a sí misma:

% PRUEBA: d(x, x, D). Resultado esperado: D = 1.
d(Var, Exp1, 1):-
    atomic(Var), ==(Exp1, Var), !.


% Derivada de una constante por una variable:

% PRUEBA: d(x, 4*x, D). Resultado esperado: D = 4.
d(Var, N*Var, N):-
    atomic(Var),  !.


% Derivada de una variable elevada a la N:

% PRUEBA: d(x, x^3, D). Resultado esperado: D = 3*x^2.
d(Var, Var^N, N*Var^Nm1):-
    atomic(Var),  is(Nm1, -(N, 1)), !.


% Derivada de una constante por una variable elevada a la N:

% PRUEBA: d(x, 4*x^3, D). Resultado esperado: D = 12*x^2.
d(Var, K*Var^N, C*Var^Nm1):-
    atomic(Var), number(N), is(C, K*N), is(Nm1, -(N, 1)), !.


% Derivada del logaritmo natural de una variable:

% PRUEBA: d(x, log(x), D). Resultado esperado: D = 1/x.
d(Var, log(Var), 1/Var):-
    atomic(Var), !.


% Drivada del seno de una varable:

% PRUEBA: d(x, sen(x), D). Resultado esperado: D = cos(x).
d(Var, sen(Var), cos(Var)):-
    atomic(Var), !.


% Drivada del coseno de una varable:

% PRUEBA: d(x, cos(x), D). Resultado esperado: D = -sen(x).
d(Var, cos(Var), -sen(Var)):-
    atomic(Var), !.


% Drivada de la tagente de una varable:

% PRUEBA: d(x, tan(x), D). Resultado esperado: D = sec(x)^2.
d(Var, tan(Var), (sec(Var))^2):-
    atomic(Var), !.


% Derivada de la suma de pos funcione:

% PRUEBA: d(x, x^2+5, D). Resultado esperado: D = 2*x^1+0.
d(Var, F+G, DF+DG):-
    atomic(Var), d(Var, F, DF), d(Var, G, DG).


% DERIVADAS PARA SU POSTERIOR EVALUACION:

% Derivada de una constante:

% PRUEBA (consulta nueva, X libre): d(X, 5, D).
% Resultado esperado: D = 0; X queda sin instanciar.
d(Var, N, 0):-
    var(Var), number(N),  !.


% Derivara de una variable respecto a sí misma:

% PRUEBA (consulta nueva, X libre): d(X, X, D).
% Resultado esperado: D = 1; X queda sin instanciar.
d(Var, Var, 1):-
    var(Var), !.


% Derivada de una constante por una variable:

% PRUEBA (consulta nueva, X libre): d(X, 4*X, D).
% Resultado esperado: D = 4; X queda sin instanciar.
d(Var, N*Var, N):-
    var(Var),  !.


% Derivada de una variable elevada a la N:

% PRUEBA (consulta nueva, X libre): d(X, X^3, D).
% Resultado esperado: D = 3*X^2; X queda sin instanciar.
d(Var, Var^N, N*Var^Nm1):-
    var(Var),  is(Nm1, -(N, 1)), !.


% Derivada de una constante por una variable elevada a la N:

% PRUEBA (consulta nueva, X libre): d(X, 4*X^3, D).
% Resultado esperado: D = 12*X^2; X queda sin instanciar.
d(Var, K*Var^N, C*Var^Nm1):-
    var(Var), number(N), is(C, K*N), is(Nm1, -(N, 1)), !.


% Derivada del logaritmo natural de una variable:

% PRUEBA (consulta nueva, X libre): d(X, log(X), D).
% Resultado esperado: D = 1/X; X queda sin instanciar.
d(Var, log(Var), 1/Var):-
    var(Var), !.


% Drivada del seno de una varable:

% PRUEBA (consulta nueva, X libre): d(X, sen(X), D).
% Resultado esperado: D = cos(X); X queda sin instanciar.
d(Var, sen(Var), cos(Var)):-
    var(Var), !.


% Drivada del coseno de una varable:

% PRUEBA (consulta nueva, X libre): d(X, cos(X), D).
% Resultado esperado: D = -sen(X); X queda sin instanciar.
d(Var, cos(Var), -sen(Var)):-
    var(Var), !.


% Drivada de la tagente de una varable:

% PRUEBA (consulta nueva, X libre): d(X, tan(X), D).
% Resultado esperado: D = sec(X)^2; X queda sin instanciar.
d(Var, tan(Var), (sec(Var))^2):-
    var(Var), !.


% Derivada de la suma de pos funcione:

% PRUEBA (consulta nueva, X libre): d(X, X^2+5, D).
% Resultado esperado: D = 2*X^1+0; X queda sin instanciar.
d(Var, F+G, DF+DG):-
    var(Var), d(Var, F, DF), d(Var, G, DG).


