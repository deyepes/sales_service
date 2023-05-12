defmodule AppNameWeb.PedidoView do
  use AppNameWeb, :view
  alias AppNameWeb.PedidoView

  def render("index.json", %{pedidos: pedidos}) do
    %{data: render_many(pedidos, PedidoView, "pedido.json")}
  end

  def render("show.json", %{pedido: pedido}) do
    IO.inspect(pedido, label: "pedido-show.json::::::")
    %{data: render_one(pedido, PedidoView, "pedido.json")}
  end

  def render("pedido.json", %{pedido: pedido}) do
    #bring usuario
    IO.inspect(pedido, label: "pedido::::::")
    ## if usuario is nil, then return []
    #usuario = cond do
    #  is_nil(pedido.usuario) ->
    #    []
    #  true ->
    #    [pedido.usuario]
    #    |> Enum.map(& Map.from_struct(&1))
    #    |> Enum.map(& Enum.reduce([:__meta__, :pedidos, :inserted_at, :updated_at], &1, fn x, acc -> Map.delete(acc, x) end))
    #end
    #usuario = [pedido.usuario]
    #    |> Enum.map(& Map.from_struct(&1))
    #    |> Enum.map(& Enum.reduce([:__meta__, :pedidos, :inserted_at, :updated_at], &1, fn x, acc -> Map.delete(acc, x) end))
    %{
      id: pedido.id,
      producto: pedido.producto,
      fecha_pedido: pedido.fecha_pedido,
      direccion_entrega: pedido.direccion_entrega,
      estado_pedido: pedido.estado_pedido,
      usuario_id: pedido.usuario_id,
      total: pedido.total
      #usuario: usuario
    }
  end

  def render("pedidos.json", %{pedidos: pedidos}) do
    %{data: render_many(pedidos, PedidoView, "pedido.json")}
  end

end
