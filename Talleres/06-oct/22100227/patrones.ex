defmodule Patrones do
  @moduledoc """
  Miercoles 30 · Coincidencia de patrones.

  Regla del dia: ni un solo `if`, `cond` ni `case` sobre el tipo. Cada decision es una
  clausula de funcion. Puedes escribir cuantas clausulas quieras de cada funcion.

      mix test test/patrones_test.exs
  """

  # 1. Descripción basada en los patrones o llaves del mapa de embarque
  def descripcion(%{tipo: :urgente}), do: "Embarque de carácter urgente"
  def descripcion(%{tipo: :express}), do: "Embarque rápido express"
  def descripcion(_embarque), do: "Embarque estándar general"

  # 2. Documentos completos evaluando las propiedades del mapa
  def documentos_completos?(%{documentos_validos: true}), do: true
  def documentos_completos?(%{completos: true}), do: true
  def documentos_completos?(_embarque), do: false

  # 3. Clasificar peso usando guardas (when) para los rangos numéricos
  def clasificar_peso(kg) when kg <= 5, do: :ligero
  def clasificar_peso(kg) when kg <= 20, do: :mediano
  def clasificar_peso(_kg), do: :pesado

  # 4. Mensaje evaluando si la tupla es de éxito o error
  def mensaje({:ok, resultado}), do: "Operación exitosa: #{resultado}"
  def mensaje({:error, razon}), do: "Ocurrió un error: #{razon}"

  # 5. Primer ID extrayendo la cabeza y la cola de una lista
  def primer_id([%{id: id} | _resto]), do: id
  def primer_id([id | _resto]) when is_integer(id) or is_binary(id), do: id
  def primer_id([]), do: nil
end