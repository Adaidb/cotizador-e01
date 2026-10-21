defmodule Cotizador do
  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  # 1-Peso invalido (menor o = a cero)
  defp validar(%{peso_kg: p}, _reglas) when p <= 0 do
    {:error, :peso_invalido}
  end

  # 2-Distancia invalida (menor o = a cero)
  defp validar(%{distancia_km: d}, _reglas) when d <= 0 do
    {:error, :distancia_invalida}
  end

  # 3 Tipo desconocido 
  defp validar(%{tipo: t}, _reglas) when t not in @tipos do
    {:error, :tipo_desconocido}
  end

  # 4 Puente desconocido 
  defp validar(%{puente: p}, reglas) when not is_map_key(reglas.cuota_puente, p) do
    {:error, :puente_desconocido}
  end

  # 5 Falta número UN 
  defp validar(%{tipo: :peligrosa, numero_un: nil}, _reglas) do
    {:error, :falta_numero_un}
  end

  # 6-Falta permiso 
  defp validar(%{tipo: :sobredimensionada, permiso: p}, _reglas) when p in [nil, false] do
    {:error, :falta_permiso}
  end

  # 7-Excepcion al peso Maximo
  # Si es sobredimensionada y llegó hasta aquí (ya validó su permiso), pasa la prueba.
  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  # 8 Excede peso maximo (general, refrigerada y peligrosa)
  
  defp validar(%{peso_kg: p}, reglas) when p > reglas.peso_maximo_kg do
    {:error, :excede_peso_maximo}
  end

  #  Si paso  el embarque es válido
  defp validar(_embarque, _reglas), do: :ok

  defp calcular(_embarque, _reglas), do: %{}
end
