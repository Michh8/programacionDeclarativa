# Programación declarativa: ejemplos en Prolog

Material de repaso para el parcial. Los cinco archivos proporcionados conservan
sus líneas de código: únicamente se agregaron comentarios. `desea_conocer.pl`
transcribe las tres versiones de la imagen, con sus limitaciones originales.

## Archivos y consultas

| Archivo | Tema | Consulta de ejemplo |
| --- | --- | --- |
| `derivadas_2026_02_sec01.pl` | Derivación simbólica y con variables | `d(x, x^3, D).` |
| `integrales_2026_02_sec01.pl` | Primitivas de constantes y potencias | `s(x, x^2, I).` |
| `campesino.pl` | Búsqueda de estados y retroceso | `juego_campesino(EI).` |
| `seis_amigos.pl` | Asignación a transportes | `seis_amigos(M).` |
| `ejercicios Logica.pl` | Clave, colores, casas, pisos y cine | `tres_senoras(L).` |
| `desea_conocer.pl` | Recursión, cortes y visitados | `desea_conocer_v3(ana, carlos, W).` |

## Cómo cargar y ejecutar con SWI-Prolog

Abre una terminal en este repositorio y ejecuta:

```powershell
swipl
```

En la consola de Prolog, escribe lo siguiente (no escribas el indicador `?-`):

```prolog
consult('derivadas_2026_02_sec01.pl').
d(x, x^3, D).
```

También puedes cargar con `['campesino.pl'].` y luego consultar
`juego_campesino(EI).`. Para nombres con espacios usa comillas simples:
`consult('ejercicios Logica.pl').`.

Desde PowerShell puedes cargar y resolver una consulta directamente:

```powershell
swipl -q -s derivadas_2026_02_sec01.pl -g "d(x,x^3,D),writeln(D)" -t halt
```

Si `swipl` no está en PATH, en esta máquina está instalado en:

```powershell
& 'C:\Program Files\swipl\bin\swipl.exe'
```

En rutas escritas dentro de Prolog usa `/`, por ejemplo
`consult('C:/carpeta/campesino.pl').`.

## Tips para el parcial

- Termina hechos, reglas y consultas con punto. Mayúscula o `_` inicia una
  variable; minúscula inicia un átomo: `X` es variable y `x` es un símbolo.
- `cabeza :- objetivo1, objetivo2.` significa que ambos objetivos deben cumplirse.
  La coma es conjunción y `;` expresa alternativas. Usa paréntesis para agrupar.
- Prolog prueba cláusulas de arriba abajo y objetivos de izquierda a derecha.
  Si falla, retrocede para buscar otra alternativa. En la consola, `;` pide
  otra respuesta y Enter acepta la actual cuando aparece el indicador de opciones.
- `X = 2+3` unifica con el término `2+3`; `X is 2+3` calcula `5`.
  `is/2` necesita valores numéricos ya conocidos en la expresión derecha.
- `=:=` compara valores aritméticos, `=\=` comprueba desigualdad numérica,
  `==` compara identidad sin asignar y `\==` comprueba falta de identidad.
  `\==` no impone una restricción futura de desigualdad sobre variables libres.
- `succ(A,B)` exige enteros y expresa `B = A+1`; no evalúa `A*2`.
- `[Cabeza|Cola]` separa una lista; `member(X,L)` busca elementos,
  `append(A,B,C)` concatena y `reverse(A,B)` invierte.
- `not(Objetivo)` (también `\+ Objetivo`) tiene éxito si el objetivo falla.
  No representa negación matemática general: el orden y la instanciación importan.
- `!` corta alternativas de la llamada actual. `fail` fuerza retroceso.
  Antes de agregar un corte, revisa qué soluciones dejarías de explorar.
- En recursión identifica caso base, paso recursivo y cómo evitas ciclos.
- `assert/1` agrega hechos y `abolish/2` elimina un predicado completo.
  Sus efectos no se revierten al retroceder; una lista de visitados viaja como argumento.
- `trace.` activa el seguimiento; `notrace.` lo desactiva. `listing(d/3).`
  muestra cláusulas y `make.` recarga archivos modificados. `halt.` sale.
- Prueba cada archivo en una sesión nueva para evitar mezclar hechos de consultas
  anteriores. Un `true` al cargar no sustituye revisar los mensajes de error.

## Probar las versiones de la imagen

La imagen no incluye hechos `conoce/2`. Para un ejemplo pequeño, en una sesión nueva:

```prolog
consult('desea_conocer.pl').
assertz(conoce(ana, bea)).
assertz(conoce(bea, carlos)).
desea_conocer_v1(ana, carlos).
desea_conocer_v2(ana, carlos).
listing(eslabon/1).
desea_conocer_v3(ana, carlos, W).
```

V1 imprime `carlos` y después `bea`. V2 guarda hechos `eslabon/1`.
V3 devuelve `W = [carlos, bea, ana]`: la lista está en orden inverso al recorrido.
V1 puede entrar en recursión infinita con ciclos; V2 mantiene visitados entre ramas.
V3 empieza con historial vacío y conserva los cortes y filtros de la imagen.

## Limitaciones originales conservadas

- En `ejercicios Logica.pl`, el bloque `sala_de_cine/1` tiene paréntesis sin
  cerrar y llamadas a `suc/2`, que no está definido. La carga muestra un error
  de sintaxis; otras cláusulas del archivo pueden quedar disponibles.
- `clave_secreta/1` pasa `*(D2, 2)` a `succ/2`, que espera un entero, por lo
  que produce un error de tipo al alcanzar esa llamada. El comentario alternativo
  del original tampoco expresa la misma relación que ese `succ/2`.
- Derivadas e integrales construyen términos y no hacen simplificación algebraica
  general. Las integrales no agregan `+ C` ni contemplan el caso de potencia `-1`.
- El campesino usa únicamente los cuatro estados prohibidos escritos en el
  original; no implementa una regla general de seguridad para cualquier estado.

Estos puntos se documentan para estudiar el comportamiento real sin modificar
los programas entregados.
