# Taller 4 · De condicionales a despacho

Nombre: Estrella Adai Diaz Bartolon
Número de control: 22100181
Equipo: 01

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar `perecedera`?
- En 4 lugares, el tipo `Tipo` y los tres `switch` de cada función.

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la demostración para perecedera?
- `tsc` no reportó ningún error

**c)** ¿Por qué el compilador no te avisó? (una línea)
- Porque las tres funciones incluyen `default` que atrapa el nuevo tipo de forma silenciosa.

## Paso 3 · El tipo nuevo, otra vez

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
- `Property 'perecedera' is missing in type ... but required in type 'Record<Tipo, Politica>'.`

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
- En 1 solo lugar (agregando la entrada correspondiente en la tabla `POLITICAS`).

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en `despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
- En Elixir lanza un `FunctionClauseError` en tiempo de ejecución. En TypeScript, el compilador te avisa en tiempo de compilación gracias al tipo estricto `Record`.