defmodule Cotizador do
  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  # ETAPA 1

  defp validar(%{peso_kg: p}, _reglas) when p <= 0, do: {:error, :peso_invalido}
  defp validar(%{distancia_km: d}, _reglas) when d <= 0, do: {:error, :distancia_invalida}
  defp validar(%{tipo: t}, _reglas) when t not in @tipos, do: {:error, :tipo_desconocido}

  defp validar(%{puente: p}, reglas) when not is_map_key(reglas.cuota_puente, p),
    do: {:error, :puente_desconocido}

  defp validar(%{tipo: :peligrosa, numero_un: nil}, _reglas), do: {:error, :falta_numero_un}

  defp validar(%{tipo: :sobredimensionada, permiso: p}, _reglas) when p in [nil, false],
    do: {:error, :falta_permiso}

  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  defp validar(%{peso_kg: p}, reglas) when p > reglas.peso_maximo_kg,
    do: {:error, :excede_peso_maximo}

  defp validar(_embarque, _reglas), do: :ok

  # etapa 2 y 3

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

  defp calcular_descuento(peso, %{criterio: :a_partir_de, umbral_kg: u, pct: p}, flete_bruto)
       when peso >= u do
    pct(flete_bruto, p)
  end

  defp calcular_descuento(peso, %{criterio: :mas_de, umbral_kg: u, pct: p}, flete_bruto)
       when peso > u do
    pct(flete_bruto, p)
  end

  defp calcular_descuento(_peso, _descuento_reglas, _flete_bruto), do: 0

  defp pct(monto, p), do: div(monto * p + 50, 100)

  def resumen(embarques, reglas) do
    embarques
    |> Enum.map(fn embarque -> {embarque, cotizar(embarque, reglas)} end)
    |> Enum.reduce(
      %{cotizados: 0, rechazados: [], total: 0, por_puente: %{comercio_mundial: 0, colombia: 0}},
      fn
        # Cláusula cuando el embarque fue exitoso ({:ok, cotizacion})
        {embarque, {:ok, cotizacion}}, acc ->
          puente = embarque.puente

          %{
            acc
            | cotizados: acc.cotizados + 1,
              total: acc.total + cotizacion.total,
              por_puente:
                Map.update!(acc.por_puente, puente, fn actual -> actual + cotizacion.total end)
          }

        # Cláusula cuando el embarque fue rechazado ({:error, motivo})
        {embarque, {:error, motivo}}, acc ->
          rechazo_info = {embarque.id, motivo}
          %{acc | rechazados: [rechazo_info | acc.rechazados]}
      end
    )
    |> update_in([:rechazados], &Enum.reverse/1)
  end

  def sumar_totales([]), do: 0

  def sumar_totales([cotizacion | resto]) do
    cotizacion.total + sumar_totales(resto)
  end
end
