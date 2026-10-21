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

  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  # 8 Excede peso maximo (general, refrigerada y peligrosa)

  defp validar(%{peso_kg: p}, reglas) when p > reglas.peso_maximo_kg do
    {:error, :excede_peso_maximo}
  end

  #  Si paso  el embarque es válido
  defp validar(_embarque, _reglas), do: :ok

  defp calcular(embarque, reglas) do
    flete_bruto = embarque.distancia_km * reglas.tarifa_km
    monto_descuento = calcular_descuento(embarque.peso_kg, reglas.descuento, flete_bruto)
    flete = flete_bruto - monto_descuento
    cuota_puente = Map.fetch!(reglas.cuota_puente, embarque.puente)

    recargo_reglas = Map.fetch!(reglas.recargo, embarque.tipo)
    base_calc = base_recargo(reglas.base_recargo, flete, cuota_puente)
    recargo = pct(base_calc, recargo_reglas.pct) + recargo_reglas.fija

    subtotal_con_recargo = flete + cuota_puente + recargo
    total = max(subtotal_con_recargo, reglas.minimo)
    ajuste_minimo = total - subtotal_con_recargo

    %{
      flete_bruto: flete_bruto,
      descuento: monto_descuento,
      flete: flete,
      cuota_puente: cuota_puente,
      recargo: recargo,
      ajuste_minimo: ajuste_minimo,
      total: total
    }
  end

  defp base_recargo(:subtotal, flete, cuota_puente), do: flete + cuota_puente

  defp base_recargo(:flete, flete, _cuota_puente), do: flete

  # Criterio 1: a_partir_de (el umbral Si lleva descuento >=)
  defp calcular_descuento(peso, %{criterio: :a_partir_de, umbral_kg: u, pct: p}, flete_bruto)
       when peso >= u do
    pct(flete_bruto, p)
  end

  # 2
  defp calcular_descuento(peso, %{criterio: :mas_de, umbral_kg: u, pct: p}, flete_bruto)
       when peso > u do
    pct(flete_bruto, p)
  end

  # Si no cumple el descuento es 0
  defp calcular_descuento(_peso, _descuento_reglas, _flete_bruto), do: 0

  defp pct(monto, p), do: div(monto * p + 50, 100)
end
