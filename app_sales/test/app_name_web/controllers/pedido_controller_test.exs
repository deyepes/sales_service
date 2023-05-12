defmodule AppNameWeb.PedidoControllerTest do
  use AppNameWeb.ConnCase

  import AppName.PedidosFixtures

  alias AppName.Pedidos.Pedido

  @create_attrs %{
    direccion_entrega: "some direccion_entrega",
    estado_pedido: "some estado_pedido",
    fecha_pedido: ~D[2023-05-05],
    producto: "some producto",
    total: 42
  }
  @update_attrs %{
    direccion_entrega: "some updated direccion_entrega",
    estado_pedido: "some updated estado_pedido",
    fecha_pedido: ~D[2023-05-06],
    producto: "some updated producto",
    total: 43
  }
  @invalid_attrs %{direccion_entrega: nil, estado_pedido: nil, fecha_pedido: nil, producto: nil, total: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pedidos", %{conn: conn} do
      conn = get(conn, Routes.pedido_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pedido" do
    test "renders pedido when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pedido_path(conn, :create), pedido: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pedido_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "direccion_entrega" => "some direccion_entrega",
               "estado_pedido" => "some estado_pedido",
               "fecha_pedido" => "2023-05-05",
               "producto" => "some producto",
               "total" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pedido_path(conn, :create), pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pedido" do
    setup [:create_pedido]

    test "renders pedido when data is valid", %{conn: conn, pedido: %Pedido{id: id} = pedido} do
      conn = put(conn, Routes.pedido_path(conn, :update, pedido), pedido: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pedido_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "direccion_entrega" => "some updated direccion_entrega",
               "estado_pedido" => "some updated estado_pedido",
               "fecha_pedido" => "2023-05-06",
               "producto" => "some updated producto",
               "total" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pedido: pedido} do
      conn = put(conn, Routes.pedido_path(conn, :update, pedido), pedido: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pedido" do
    setup [:create_pedido]

    test "deletes chosen pedido", %{conn: conn, pedido: pedido} do
      conn = delete(conn, Routes.pedido_path(conn, :delete, pedido))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pedido_path(conn, :show, pedido))
      end
    end
  end

  defp create_pedido(_) do
    pedido = pedido_fixture()
    %{pedido: pedido}
  end
end
