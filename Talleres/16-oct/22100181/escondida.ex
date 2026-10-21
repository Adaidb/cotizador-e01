defmodule Escondida do
  # Taller 3 · La mutación escondida, en Elixir.
  # Las mismas cinco funciones de escondida.ts, pero aquí no hay nada que esconder:
  # cada una regresa un valor NUEVO y no puede tocar lo que recibió.

  # 1 
  def ordenar_por_peso(embarques) do
    Enum.sort_by(embarques, & &1.pesoKg)
  end

  # 2 
  def con_descuento(reglas, pct) do
    %{reglas | descuentoPct: pct}
  end

  # 3 
  def registrar(vistos, id) do
    vistos ++ [id]
  end

  # 4  dentro de otro mapa. Hay que hacer uno nuevo en los dos niveles.
  def con_permiso(embarque, permiso) do
    %{embarque | documentos: %{embarque.documentos | permiso: permiso}}
  end

  # 5  La fecha de salida más unos días
  def fecha_de_entrega(salida, dias) do
    Date.add(salida, dias)
  end
end