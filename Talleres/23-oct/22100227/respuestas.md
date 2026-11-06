# Taller 4 · De condicionales a despacho

Nombre: Angel Rogelio Rodriguez Fernandez
Número de control: 22100227
Equipo: 01

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`?
En cuatro lugares (en el tipo `Tipo` y en los tres `switch` de cada función).

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?
`tsc` no marcó ningún error (no se quejó), y la demostración imprimió `perecedera  0  null  General`.

**c)** ¿Por qué el compilador no te avisó? (una línea)
Porque las tres funciones cuentan con un caso `default`, haciendo que el nuevo tipo cayera ahí en silencio.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.
El compilador se quejó indicando que a la tabla `POLITICAS` le falta la llave `perecedera` debido al uso de `Record<Tipo, Politica>` (Ej: `Property 'perecedera' is missing in type...`).

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?
Solo un lugar (agregar la entrada correspondiente a `perecedera` dentro del objeto `POLITICAS`).

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)
En Elixir se lanza un `FunctionClauseError` en tiempo de ejecución, mientras que en TypeScript con `Record` el compilador avisa en tiempo de compilación. TypeScript te avisa antes.