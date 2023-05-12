defmodule AppName.UsuariosTest do
  use AppName.DataCase

  alias AppName.Usuarios

  describe "usuarios" do
    alias AppName.Usuarios.Usuario

    import AppName.UsuariosFixtures

    @invalid_attrs %{apellido: nil, correo_electronico: nil, direccion: nil, nombre: nil, num_id: nil, telefono: nil}

    test "list_usuarios/0 returns all usuarios" do
      usuario = usuario_fixture()
      assert Usuarios.list_usuarios() == [usuario]
    end

    test "get_usuario!/1 returns the usuario with given id" do
      usuario = usuario_fixture()
      assert Usuarios.get_usuario!(usuario.id) == usuario
    end

    test "create_usuario/1 with valid data creates a usuario" do
      valid_attrs = %{apellido: "some apellido", correo_electronico: "some correo_electronico", direccion: "some direccion", nombre: "some nombre", num_id: "some num_id", telefono: "some telefono"}

      assert {:ok, %Usuario{} = usuario} = Usuarios.create_usuario(valid_attrs)
      assert usuario.apellido == "some apellido"
      assert usuario.correo_electronico == "some correo_electronico"
      assert usuario.direccion == "some direccion"
      assert usuario.nombre == "some nombre"
      assert usuario.num_id == "some num_id"
      assert usuario.telefono == "some telefono"
    end

    test "create_usuario/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Usuarios.create_usuario(@invalid_attrs)
    end

    test "update_usuario/2 with valid data updates the usuario" do
      usuario = usuario_fixture()
      update_attrs = %{apellido: "some updated apellido", correo_electronico: "some updated correo_electronico", direccion: "some updated direccion", nombre: "some updated nombre", num_id: "some updated num_id", telefono: "some updated telefono"}

      assert {:ok, %Usuario{} = usuario} = Usuarios.update_usuario(usuario, update_attrs)
      assert usuario.apellido == "some updated apellido"
      assert usuario.correo_electronico == "some updated correo_electronico"
      assert usuario.direccion == "some updated direccion"
      assert usuario.nombre == "some updated nombre"
      assert usuario.num_id == "some updated num_id"
      assert usuario.telefono == "some updated telefono"
    end

    test "update_usuario/2 with invalid data returns error changeset" do
      usuario = usuario_fixture()
      assert {:error, %Ecto.Changeset{}} = Usuarios.update_usuario(usuario, @invalid_attrs)
      assert usuario == Usuarios.get_usuario!(usuario.id)
    end

    test "delete_usuario/1 deletes the usuario" do
      usuario = usuario_fixture()
      assert {:ok, %Usuario{}} = Usuarios.delete_usuario(usuario)
      assert_raise Ecto.NoResultsError, fn -> Usuarios.get_usuario!(usuario.id) end
    end

    test "change_usuario/1 returns a usuario changeset" do
      usuario = usuario_fixture()
      assert %Ecto.Changeset{} = Usuarios.change_usuario(usuario)
    end
  end
end
