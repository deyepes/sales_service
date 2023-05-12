defmodule AppName.UsuariosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AppName.Usuarios` context.
  """

  @doc """
  Generate a usuario.
  """
  def usuario_fixture(attrs \\ %{}) do
    {:ok, usuario} =
      attrs
      |> Enum.into(%{
        apellido: "some apellido",
        correo_electronico: "some correo_electronico",
        direccion: "some direccion",
        nombre: "some nombre",
        num_id: "some num_id",
        telefono: "some telefono"
      })
      |> AppName.Usuarios.create_usuario()

    usuario
  end
end
