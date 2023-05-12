defmodule AppName.PedidosTest do
  use AppName.DataCase

  alias AppName.Pedidos

  describe "pedidos" do
    alias AppName.Pedidos.Pedido

    import AppName.PedidosFixtures

    @invalid_attrs %{direccion_entrega: nil, estado_pedido: nil, fecha_pedido: nil, producto: nil, total: nil}

    test "list_pedidos/0 returns all pedidos" do
      pedido = pedido_fixture()
      assert Pedidos.list_pedidos() == [pedido]
    end

    test "get_pedido!/1 returns the pedido with given id" do
      pedido = pedido_fixture()
      assert Pedidos.get_pedido!(pedido.id) == pedido
    end

    test "create_pedido/1 with valid data creates a pedido" do
      valid_attrs = %{direccion_entrega: "some direccion_entrega", estado_pedido: "some estado_pedido", fecha_pedido: ~D[2023-05-05], producto: "some producto", total: 42}

      assert {:ok, %Pedido{} = pedido} = Pedidos.create_pedido(valid_attrs)
      assert pedido.direccion_entrega == "some direccion_entrega"
      assert pedido.estado_pedido == "some estado_pedido"
      assert pedido.fecha_pedido == ~D[2023-05-05]
      assert pedido.producto == "some producto"
      assert pedido.total == 42
    end

    test "create_pedido/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pedidos.create_pedido(@invalid_attrs)
    end

    test "update_pedido/2 with valid data updates the pedido" do
      pedido = pedido_fixture()
      update_attrs = %{direccion_entrega: "some updated direccion_entrega", estado_pedido: "some updated estado_pedido", fecha_pedido: ~D[2023-05-06], producto: "some updated producto", total: 43}

      assert {:ok, %Pedido{} = pedido} = Pedidos.update_pedido(pedido, update_attrs)
      assert pedido.direccion_entrega == "some updated direccion_entrega"
      assert pedido.estado_pedido == "some updated estado_pedido"
      assert pedido.fecha_pedido == ~D[2023-05-06]
      assert pedido.producto == "some updated producto"
      assert pedido.total == 43
    end

    test "update_pedido/2 with invalid data returns error changeset" do
      pedido = pedido_fixture()
      assert {:error, %Ecto.Changeset{}} = Pedidos.update_pedido(pedido, @invalid_attrs)
      assert pedido == Pedidos.get_pedido!(pedido.id)
    end

    test "delete_pedido/1 deletes the pedido" do
      pedido = pedido_fixture()
      assert {:ok, %Pedido{}} = Pedidos.delete_pedido(pedido)
      assert_raise Ecto.NoResultsError, fn -> Pedidos.get_pedido!(pedido.id) end
    end

    test "change_pedido/1 returns a pedido changeset" do
      pedido = pedido_fixture()
      assert %Ecto.Changeset{} = Pedidos.change_pedido(pedido)
    end
  end
end
