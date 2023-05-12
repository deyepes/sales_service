defmodule AppName.Pedidos do
  @moduledoc """
  The Pedidos context.
  """

  import Ecto.Query, warn: false
  alias AppName.Repo

  alias AppName.Pedidos.Pedido
  alias AppName.Usuarios.Usuario

  @doc """
  Returns the list of pedidos.

  ## Examples

      iex> list_pedidos()
      [%Pedido{}, ...]

  """
  def list_pedidos do
    Repo.all(Pedido) |> Repo.preload(:usuario)
  end

  @doc """
  Gets a single pedido.

  Raises `Ecto.NoResultsError` if the Pedido does not exist.

  ## Examples

      iex> get_pedido!(123)
      %Pedido{}

      iex> get_pedido!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pedido!(id), do: Repo.get!(Pedido, id) |> Repo.preload(:usuario)

  ## get pedidos of usuario
  def get_pedidos_of_usuario!(id) do
    usuario = Repo.get!(Usuario, id)
    IO.inspect(usuario, label: "usuario:")
    usuario
      |> Repo.preload(:pedidos)
      |> Map.get(:pedidos)
  end

  ## get pedidos por estado
  def get_pedidos_por_estado!(estado_pedido) do
    query = from(p in Pedido, where: p.estado_pedido == ^estado_pedido)
    Repo.all(query) |> Repo.preload(:usuario)
  end

  @doc """
  Creates a pedido.

  ## Examples

      iex> create_pedido(%{field: value})
      {:ok, %Pedido{}}

      iex> create_pedido(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pedido(attrs \\ %{}) do
    %Pedido{}
    |> Repo.preload(:usuario)
    |> Pedido.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a pedido.

  ## Examples

      iex> update_pedido(pedido, %{field: new_value})
      {:ok, %Pedido{}}

      iex> update_pedido(pedido, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pedido(%Pedido{} = pedido, attrs) do
    pedido
    |> Pedido.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pedido.

  ## Examples

      iex> delete_pedido(pedido)
      {:ok, %Pedido{}}

      iex> delete_pedido(pedido)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pedido(%Pedido{} = pedido) do
    Repo.delete(pedido)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pedido changes.

  ## Examples

      iex> change_pedido(pedido)
      %Ecto.Changeset{data: %Pedido{}}

  """
  def change_pedido(%Pedido{} = pedido, attrs \\ %{}) do
    Pedido.changeset(pedido, attrs)
  end
end
