defmodule AgoraWeb.OrgControllerTest do
  use AgoraWeb.ConnCase

  alias Agora.Accounts
  alias Agora.Accounts.Org

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:org) do
    {:ok, org} = Accounts.create_org(@create_attrs)
    org
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orgs", %{conn: conn} do
      conn = get(conn, Routes.org_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create org" do
    test "renders org when data is valid", %{conn: conn} do
      conn = post(conn, Routes.org_path(conn, :create), org: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.org_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.org_path(conn, :create), org: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update org" do
    setup [:create_org]

    test "renders org when data is valid", %{conn: conn, org: %Org{id: id} = org} do
      conn = put(conn, Routes.org_path(conn, :update, org), org: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.org_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, org: org} do
      conn = put(conn, Routes.org_path(conn, :update, org), org: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete org" do
    setup [:create_org]

    test "deletes chosen org", %{conn: conn, org: org} do
      conn = delete(conn, Routes.org_path(conn, :delete, org))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.org_path(conn, :show, org))
      end
    end
  end

  defp create_org(_) do
    org = fixture(:org)
    {:ok, org: org}
  end
end
