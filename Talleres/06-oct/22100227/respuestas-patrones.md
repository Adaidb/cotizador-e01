# Taller · coincidencia de patrones

Nombre: Angel Rogelio Rodriguez Fernandez
Número de control: 22100227
Equipo: 1

Copia este archivo a `talleres/06-oct/<tu número de control>/respuestas.md` en el repositorio de tu pareja,
junto con tu `patrones.ex`. Entrega: el mismo día del taller, antes de las 23:59.

## 1. ¿Por qué importa el orden de las cláusulas?

Explícalo con un ejemplo de TU `patrones.ex`: qué pasaría si cambias de lugar dos cláusulas.

El orden importa porque Elixir evalúa las cláusulas de arriba hacia abajo de manera secuencial y se queda con la primera que coincida con los argumentos proporcionados.

## 2. ¿Qué pasa cuando ninguna cláusula coincide?

¿Qué error da Elixir, y por qué es mejor que regresar un valor por omisión en silencio?

Cuando se le pasa un argumento a una función y ninguna de sus cláusulas coincide, Elixir lanza un error de tipo FunctionClauseError.

## 3. Escribiste `documentos_completos?` sin un solo `if`. ¿Cuántas cláusulas usaste y en qué orden?

Utilicé un total de 3 cláusulas organizadas en el siguiente orden:   

def documentos_completos?(%{documentos_validos: true}), do: true (Verifica si explícitamente el mapa indica que los documentos son válidos).

def documentos_completos?(%{completos: true}), do: true (Verifica la bandera alternativa de completos).

def documentos_completos?(_embarque), do: false (Cláusula comodín que capta cualquier otra estructura o estado faltante y retorna false por defecto).