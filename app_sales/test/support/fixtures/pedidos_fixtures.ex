defmodule AppName.PedidosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AppName.Pedidos` context.
  """

  @doc """
  Generate a pedido.
  """
  def pedido_fixture(attrs \\ %{}) do
    {:ok, pedido} =
      attrs
      |> Enum.into(%{
        direccion_entrega: "some direccion_entrega",
        estado_pedido: "some estado_pedido",
        fecha_pedido: ~D[2023-05-05],
        producto: "some producto",
        total: 42
      })
      |> AppName.Pedidos.create_pedido()

    pedido
  end
end
