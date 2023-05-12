defmodule AppNameWeb.UsuarioControllerTest do
  use AppNameWeb.ConnCase

  import AppName.UsuariosFixtures

  alias AppName.Usuarios.Usuario

  @create_attrs %{
    apellido: "some apellido",
    correo_electronico: "some correo_electronico",
    direccion: "some direccion",
    nombre: "some nombre",
    num_id: "some num_id",
    telefono: "some telefono"
  }
  @update_attrs %{
    apellido: "some updated apellido",
    correo_electronico: "some updated correo_electronico",
    direccion: "some updated direccion",
    nombre: "some updated nombre",
    num_id: "some updated num_id",
    telefono: "some updated telefono"
  }
  @invalid_attrs %{apellido: nil, correo_electronico: nil, direccion: nil, nombre: nil, num_id: nil, telefono: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all usuarios", %{conn: conn} do
      conn = get(conn, Routes.usuario_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create usuario" do
    test "renders usuario when data is valid", %{conn: conn} do
      conn = post(conn, Routes.usuario_path(conn, :create), usuario: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.usuario_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "apellido" => "some apellido",
               "correo_electronico" => "some correo_electronico",
               "direccion" => "some direccion",
               "nombre" => "some nombre",
               "num_id" => "some num_id",
               "telefono" => "some telefono"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.usuario_path(conn, :create), usuario: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update usuario" do
    setup [:create_usuario]

    test "renders usuario when data is valid", %{conn: conn, usuario: %Usuario{id: id} = usuario} do
      conn = put(conn, Routes.usuario_path(conn, :update, usuario), usuario: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.usuario_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "apellido" => "some updated apellido",
               "correo_electronico" => "some updated correo_electronico",
               "direccion" => "some updated direccion",
               "nombre" => "some updated nombre",
               "num_id" => "some updated num_id",
               "telefono" => "some updated telefono"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, usuario: usuario} do
      conn = put(conn, Routes.usuario_path(conn, :update, usuario), usuario: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete usuario" do
    setup [:create_usuario]

    test "deletes chosen usuario", %{conn: conn, usuario: usuario} do
      conn = delete(conn, Routes.usuario_path(conn, :delete, usuario))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.usuario_path(conn, :show, usuario))
      end
    end
  end

  defp create_usuario(_) do
    usuario = usuario_fixture()
    %{usuario: usuario}
  end
end
