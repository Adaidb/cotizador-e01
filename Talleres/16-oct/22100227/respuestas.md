# Taller 3 · La mutación escondida

Nombre: Angel Rogelio Rodriguez Fernandez
Número de control: 22100227
Equipo: 1

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · | true | false |
| 2 · | true | false |
| 3 · | false | true |
| 4 · | false | false |
| 5 · | true | false |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | Modifica el arreglo original ordenándolo in-place con `.sort()`. | Cualquier otra variable o componente que apunte al mismo arreglo. |
| 2 | conDescuento | Modifica una propiedad del objeto de reglas original. | Cualquier referencia global o módulo que comparta ese objeto de reglas. |
| 3 | registrar | Añade elementos a un arreglo global compartido usando `.push()`. | Todo el sistema o funciones que lean esa variable global de elementos vistos. |
| 4 | conPermiso | Modifica una propiedad anidada dentro del objeto `documentos` del embarque. | Cualquier función que comparta la referencia de ese embarque original. |
| 5 | fechaDeEntrega | Modifica el objeto de fecha subyacente si se usan métodos mutables. | Cualquier otra variable que referencie la misma fecha de salida. |

## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es posible? 
Porque aunque se creó un contenedor o copia superficial nueva (por lo que las referencias principales ya no son estrictamente iguales), las estructuras internas anidadas (como el objeto `documentos`) seguían apuntando a la misma referencia de memoria original (mutación por referencia compartida).

**b)** ¿Por qué `registrar` no es una función pura? 
Porque depende y modifica un estado externo o global compartido (produce efectos secundarios / *side effects*).

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual. ¿Por qué en Elixir esa aserción no puede fallar? 
Porque en Elixir los datos son estrictamente inmutables por diseño del lenguaje; cualquier operación genera una estructura completamente nueva en memoria sin alterar jamás la original.