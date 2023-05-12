defmodule AppNameWeb.UsuarioController do
  use AppNameWeb, :controller

  alias AppName.Pedidos
  alias AppName.Usuarios
  alias AppName.Usuarios.Usuario

  action_fallback AppNameWeb.FallbackController

  def index(conn, _params) do
    usuarios = Usuarios.list_usuarios()
    render(conn, "index.json", usuarios: usuarios)
  end

  def create(conn, %{"usuario" => usuario_params}) do
    with {:ok, %Usuario{} = usuario} <- Usuarios.create_usuario(usuario_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", Routes.usuario_path(conn, :show, usuario))
      |> render("show.json", usuario: usuario)
    end
  end

  def show(conn, %{"id" => id}) do
    usuario = Usuarios.get_usuario!(id)
    render(conn, "show.json", usuario: usuario)
  end

  def update(conn, %{"id" => id, "usuario" => usuario_params}) do
    usuario = Usuarios.get_usuario!(id)

    with {:ok, %Usuario{} = usuario} <- Usuarios.update_usuario(usuario, usuario_params) do
      render(conn, "show.json", usuario: usuario)
    end
  end

  def delete(conn, %{"id" => id}) do
    usuario = Usuarios.get_usuario!(id)

    with {:ok, %Usuario{}} <- Usuarios.delete_usuario(usuario) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_pedidos(conn, %{"id" => id}) do
    IO.inspect(id, label: "id::::::")
    pedidos = Pedidos.get_pedidos_of_usuario!(id)
    IO.inspect(pedidos, label: "pedidos::::::")
    render(conn, "pedidos.json", pedidos: pedidos)
  end

end
