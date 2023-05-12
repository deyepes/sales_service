defmodule AppName.Repo.Migrations.CreatePedidos do
  use Ecto.Migration

  def change do
    create table(:pedidos, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :producto, :string
      add :fecha_pedido, :date
      add :direccion_entrega, :string
      add :estado_pedido, :string
      add :total, :integer
      add :usuario_id, references(:usuarios, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:pedidos, [:usuario_id])
  end
end
