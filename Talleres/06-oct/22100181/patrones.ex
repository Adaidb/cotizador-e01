defmodule Patrones do
 test "1 · descripcion: una clausula por tipo; la peligrosa trae su numero UN" do
  def descripcion(%{tipo: :general}), do: "Carga general"
  def descripcion(%{tipo: :refrigerada}), do: "Carga refrigerada"
  def descripcion(%{tipo: :peligrosa, numero_un: numero_un}), do: "Carga peligrosa (#{numero_un})"
  def descripcion(%{tipo: :sobredimensionada}), do: "Carga sobredimensionada"

  # 2. documentos_completos?sin un solo if" do
  def documentos_completos?(%{tipo: :peligrosa, numero_un: nil}), do: false
  def documentos_completos?(%{tipo: :peligrosa, numero_un: numero_un}) when is_binary(numero_un), do: true
  def documentos_completos?(%{tipo: :sobredimensionada, permiso: nil}), do: false
  def documentos_completos?(%{tipo: :sobredimensionada, permiso: permiso}) when is_binary(permiso), do: true
  def documentos_completos?(%{tipo: :general}), do: true

  test "3 · clasificar_peso con guardas, y las fronteras exactas" do
  def clasificar_peso(peso) when peso <= 0, do: :invalido
  def clasificar_peso(peso) when peso < 1000, do: :ligero
  def clasificar_peso(peso) when peso < 10_000, do: :medio
  def clasificar_peso(_peso), do: :pesado

 test "4 · mensaje descompone el resultado" do
  def mensaje({:ok, total}), do: "Total: #{total}"
  def mensaje({:error, razon}), do: "Rechazado: #{razon}"

   5. 
  def primer_id([]), do: :vacio
  def primer_id([%{id: id} | _resto]), do: id
end