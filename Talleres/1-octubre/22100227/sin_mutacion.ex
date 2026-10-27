defmodule SinMutacion do
 //ejercio1
  def total_pesos(embarques) do
    Enum.sum_by(embarques, fn e -> e.peso_kg end)
  end
//ejercio2
  def marcar_urgentes(embarques) do
    Enum.map(embarques, fn e ->
      Map.put(e, :urgente, e.distancia_km > 500)
    end)
  end
//ejericio3
  def aplicar_descuento(precios, pct) do
    Enum.map(precios, fn precio ->
      descuento = div(precio * pct + 50, 100)
      precio - descuento
    end)
  end
//ejercicio4
  def contar_por_tipo(embarques) do
    Enum.frequencies_by(embarques, fn e -> e.tipo end)
  end

//ejercicio5
  def sin_duplicados(ids) do
  
  {_vistos, resultado} =
    Enum.reduce(ids, {MapSet.new(), []}, fn id, {vistos, acc} ->
      if MapSet.member?(vistos, id) do
        {vistos, acc}
      else
        {MapSet.put(vistos, id), [id | acc]}
      end
    end)

  Enum.reverse(resultado)
end