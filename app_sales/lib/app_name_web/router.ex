defmodule AppNameWeb.Router do
  alias AppNameWeb.UsuarioController
  alias AppNameWeb.PedidoController
  use AppNameWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    resources "/usuarios", UsuarioController, except: [:new, :edit, :update]
    get "/pedidodeusuario/:id", UsuarioController, :get_pedidos
    get "/pedidoporestado/:estado_pedido", PedidoController, :get_pedidos_con_estado
    put "/usuarios/:id", UsuarioController, :update
    resources "/pedidos", PedidoController, except: [:new, :edit, :update]
    put "/pedidos/:id", PedidoController, :update
  end
end
