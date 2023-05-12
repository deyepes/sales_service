defmodule AppNameWeb.UsuarioView do
  use AppNameWeb, :view
  alias AppNameWeb.UsuarioView
  alias AppNameWeb.PedidoView


  def render("index.json", %{usuarios: usuarios}) do
    %{data: render_many(usuarios, UsuarioView, "usuario.json")}
  end

  def render("show.json", %{usuario: usuario}) do
    %{data: render_one(usuario, UsuarioView, "usuario.json")}
  end

  def render("usuario.json", %{usuario: usuario}) do
    # bring pedidos
    pedidos = usuario.pedidos
    |> Enum.map(& Map.from_struct(&1))
    |> Enum.map(& Enum.reduce([:__meta__, :usuario, :usuario_id, :inserted_at, :updated_at], &1, fn x, acc -> Map.delete(acc, x) end))
    %{
      id: usuario.id,
      num_id: usuario.num_id,
      nombre: usuario.nombre,
      apellido: usuario.apellido,
      correo_electronico: usuario.correo_electronico,
      direccion: usuario.direccion,
      telefono: usuario.telefono,
      pedidos: pedidos
    }
  end

  def render("pedidos.json", %{pedidos: pedidos}) do
    %{data: render_many(pedidos, PedidoView, "pedido.json")}
  end

end
