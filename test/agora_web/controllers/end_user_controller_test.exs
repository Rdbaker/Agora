defmodule AgoraWeb.EndUserControllerTest do
  use AgoraWeb.ConnCase

  alias Agora.Accounts

  @create_attrs %{username: "some username"}
  @update_attrs %{username: "some updated username"}
  @invalid_attrs %{username: nil}

  def fixture(:end_user) do
    {:ok, end_user} = Accounts.create_end_user(@create_attrs)
    end_user
  end

  describe "index" do
    test "lists all end_users", %{conn: conn} do
      conn = get(conn, Routes.end_user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing End users"
    end
  end

  describe "new end_user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.end_user_path(conn, :new))
      assert html_response(conn, 200) =~ "New End user"
    end
  end

  describe "create end_user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.end_user_path(conn, :create), end_user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.end_user_path(conn, :show, id)

      conn = get(conn, Routes.end_user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show End user"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.end_user_path(conn, :create), end_user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New End user"
    end
  end

  describe "edit end_user" do
    setup [:create_end_user]

    test "renders form for editing chosen end_user", %{conn: conn, end_user: end_user} do
      conn = get(conn, Routes.end_user_path(conn, :edit, end_user))
      assert html_response(conn, 200) =~ "Edit End user"
    end
  end

  describe "update end_user" do
    setup [:create_end_user]

    test "redirects when data is valid", %{conn: conn, end_user: end_user} do
      conn = put(conn, Routes.end_user_path(conn, :update, end_user), end_user: @update_attrs)
      assert redirected_to(conn) == Routes.end_user_path(conn, :show, end_user)

      conn = get(conn, Routes.end_user_path(conn, :show, end_user))
      assert html_response(conn, 200) =~ "some updated username"
    end

    test "renders errors when data is invalid", %{conn: conn, end_user: end_user} do
      conn = put(conn, Routes.end_user_path(conn, :update, end_user), end_user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit End user"
    end
  end

  describe "delete end_user" do
    setup [:create_end_user]

    test "deletes chosen end_user", %{conn: conn, end_user: end_user} do
      conn = delete(conn, Routes.end_user_path(conn, :delete, end_user))
      assert redirected_to(conn) == Routes.end_user_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.end_user_path(conn, :show, end_user))
      end
    end
  end

  defp create_end_user(_) do
    end_user = fixture(:end_user)
    {:ok, end_user: end_user}
  end
end
