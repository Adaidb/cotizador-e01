# Taller · coincidencia de patrones

Nombre: Estrella Adai Diaz
Número de control: 22100181
Equipo: 1

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

Porque elixir evalúa las cláusulas de una función de arriba hacia abajo en orden secuencial.


Ejemplo de `clasificar_peso` :

Si invierto el orden de las  `< 10000` y `< 1000`:


# ORDEN INCORRECTO:
def clasificar_peso(peso) when peso < 10_000, do: :medio
def clasificar_peso(peso) when peso < 1000, do: :ligero

Si pongo primero la condición peso < 10000 antes que peso < 1000 elixir va de arriba hacia abajo y al mandarle un valor como 500 checa la primera regla y ve que 500 es menor a 10000 y regresa :medio , Como ya encontro una coincidencia se detiene ahi y ya no llega a revisar la segunda cláusula (peso < 1000)

## 2. ¿Qué pasa cuando ninguna cláusula coincide?
Elixir lanza un error de ejecución de tipo FunctionClauseError.
y si se regresa un valor por omision como nil o false, los datos entran al sistema haciendo algunos bugs silenciosos.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?
use 5 clausulas, primero que entren las que son muy especificas y despues las mas generales