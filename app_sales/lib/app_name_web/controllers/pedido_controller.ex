defmodule AppNameWeb.PedidoController do
  use AppNameWeb, :controller

  alias AppName.Pedidos
  alias AppName.Pedidos.Pedido

  action_fallback AppNameWeb.FallbackController

  def index(conn, _params) do
    pedidos = Pedidos.list_pedidos()
    render(conn, "index.json", pedidos: pedidos)
  end

  def create(conn, %{"pedido" => pedido_params}) do
    IO.inspect(pedido_params, label: "pedido_params::::::")
    with {:ok, %Pedido{} = pedido} <- Pedidos.create_pedido(pedido_params) do
      IO.inspect(pedido, label: "pedido en create::::::")
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.pedido_path(conn, :show, pedido))
      |> render("show.json", pedido: pedido)
    end
  end

  def show(conn, %{"id" => id}) do
    pedido = Pedidos.get_pedido!(id)
    render(conn, "show.json", pedido: pedido)
  end

  def update(conn, %{"id" => id, "pedido" => pedido_params}) do
    pedido = Pedidos.get_pedido!(id)

    with {:ok, %Pedido{} = pedido} <- Pedidos.update_pedido(pedido, pedido_params) do
      render(conn, "show.json", pedido: pedido)
    end
  end

  def delete(conn, %{"id" => id}) do
    pedido = Pedidos.get_pedido!(id)

    with {:ok, %Pedido{}} <- Pedidos.delete_pedido(pedido) do
      send_resp(conn, :no_content, "")
    end
  end


  def get_pedidos_con_estado(conn, %{"estado_pedido" => estado_pedido}) do
    IO.puts("____________________*****")
    IO.inspect(estado_pedido, label: "estado_pedido::::::")
    pedidos = Pedidos.get_pedidos_por_estado!(estado_pedido)
    IO.inspect(pedidos, label: "pedidos::::::")
    render(conn, "pedidos.json", pedidos: pedidos)
  end


end
