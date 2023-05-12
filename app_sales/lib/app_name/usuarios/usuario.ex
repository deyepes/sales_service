defmodule AppName.Usuarios.Usuario do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "usuarios" do
    field :apellido, :string
    field :correo_electronico, :string
    field :direccion, :string
    field :nombre, :string
    field :num_id, :string
    field :telefono, :string
    has_many :pedidos, AppName.Pedidos.Pedido

    timestamps()
  end

  @doc false
  def changeset(usuario, attrs) do
    usuario
    |> cast(attrs, [:num_id, :nombre, :apellido, :correo_electronico, :direccion, :telefono])
    |> validate_required([:num_id, :nombre, :apellido, :correo_electronico, :direccion, :telefono])
    |> unique_constraint(:num_id, message: "El número de identificación ya existe")
  end
end
