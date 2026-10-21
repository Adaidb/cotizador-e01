# Taller 3 · La mutación escondida

Nombre: Estrella Adai Diaz Bartolon
Número de control: 22100181
Equipo: 01

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.
Línea | Predigo | Salió |
|---|---|---|
| 1 · | A,B false | B,A true |
| 2 · | 10 true | 10 true |
| 3 · | 2 true | 2 true |
| 4 · | null true | SCT-77 false |
| 5 · | 12 15 | 15 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | `embarques.sort(...)` reordena el arreglo original en el mismo espacio de memoria (in-place) y regresa la misma referencia. | Cualquier otra referencia o pantalla que muestre los embarques con el orden original de llegada. |
| 2 | conDescuento | Modifica la propiedad `reglas.descuentoPct = pct` directamente dentro del objeto recibido y regresa la misma referencia. | Cualquier otro cliente o módulo del sistema que comparta esas mismas reglas base de descuento. |
| 3 | registrar | Modifica la lista externa compartida usando `vistos.push(id)` y regresa la misma referencia de la caja. | Cualquier otra parte del código  |
| 4 | conPermiso | Modifica el objeto interno `copia.documentos.permiso` porque el operador spread (`{...e}`) solo hace una copia superficial| El objeto `original`, ya que ambos comparten exactamente la misma referencia del objeto  `documentos`. |
| 5 | fechaDeEntrega | Modifica el objeto mutable `Date` en su lugar usando `.setDate()`, cambia la fecha original recibida. | Cualquier otra parte del registro que mantenga una referencia a esa fecha |
## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? Porque el operador (`{...e}`) realiza únicamente una copia superficial  el objeto interno `documentos` sigue siendo exactamente el mismo en ambos objetos.

**b)** ¿Por qué `registrar` no es una función pura? Porque depende de un estado mutable externo y modifica variables fuera de su ámbito

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? Porque en Elixir todas las estructuras de datos son inmutables, cualquier operación hace una copia nueva sin cambiar el objeto o estructura original.
