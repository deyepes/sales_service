defmodule AppName.Pedidos.Pedido do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pedidos" do
    field :direccion_entrega, :string
    field :estado_pedido, :string
    field :fecha_pedido, :date
    field :producto, :string
    field :total, :integer
    belongs_to :usuario, AppName.Usuarios.Usuario
    timestamps()
  end

  @doc false
  def changeset(pedido, attrs) do
    pedido
    |> cast(attrs, [:producto, :fecha_pedido, :direccion_entrega, :estado_pedido, :total, :usuario_id])
    |> validate_required([:producto, :fecha_pedido, :direccion_entrega, :estado_pedido, :producto, :total])
  end
end
