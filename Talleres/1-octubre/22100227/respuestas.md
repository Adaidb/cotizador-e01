| # | Función | ¿Qué muta la versión de TypeScript? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | total_pesos |El acumulador Total |Es Local |
| 2 | marcar_urgentes |Los objetos prestados Embarque |Todo lo que haga referencia a embarque |
| 3 | aplicar_descuento |precios[] |Todo lo que apunte  a precios|
| 4 | contar_por_tipo |contador conteo |nadie |
| 5 | sin_duplicados |set y array |Nadie |

¿Cuál de las cinco era la más peligrosa en TypeScript, y por qué? (dos líneas)
La segunda porque muta los objetos 