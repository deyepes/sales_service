defmodule AppName.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :num_id, :string
      add :nombre, :string
      add :apellido, :string
      add :correo_electronico, :string
      add :direccion, :string
      add :telefono, :string

      timestamps()
    end

    create unique_index(:usuarios, [:num_id])
  end
end
