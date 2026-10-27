# Taller 5 · Composición o herencia

Nombre: Estrella Adai Diaz Bartolon
Número de control: 22100181
Equipo: 01

Copia este archivo a `talleres/27-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `composicion.ts`. Entrega: martes 27 de octubre, 23:59.

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?
* En `ConSeguro` y en `RefrigeradaConSeguro`. `RefrigeradaConSeguro` hereda de `Refrigerada` para obtener el frío, pero en TypeScript una clase solo puede heredar de una sola clase padre, por lo que no puede heredar simultáneamente de `ConSeguro`. Esto obliga a duplicar el código del cálculo del seguro.

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.
* Se necesitan 8 clases en total . Como actualmente hay 4 clases, son 4 nuevas (express solo, frío + express, seguro + express, y los tres extras).

## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?
* Se agregó únicamente la constante `express` de una línea. La función `cotizar` no sufrió ningún cambio, ya que funciona de manera genérica con cualquier lista de funciones `Ajuste`.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** ¿Por qué salen distintos? (dos líneas)
* Porque al colocar `express` primero, el porcentaje del seguro se calcula sobre el costo base más los $500 fijos del envío exprés. Si el seguro va primero, solo se calcula sobre el costo base del flete.

## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con
composición? Cita el archivo y la función.
* Con composición, aplicando transformaciones funcionales y acumuladores sobre los datos del sistema de control de carga y guías de envío.

**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no
hay explosión de combinaciones. (tres líneas)
* En jerarquías de excepciones personalizadas como `class EmbarqueRechazado extends Error`. No hay explosión de combinaciones porque representan una sola dimensión de variación de tipo "es un" (`is-a`), donde los hijos heredan directamente el comportamiento base sin requerir combinaciones múltiples entre sí.