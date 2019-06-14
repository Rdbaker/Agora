defmodule AgoraWeb.MessageControllerTest do
  use AgoraWeb.ConnCase

  alias Agora.Messages
  alias Agora.Messages.Message

  @create_attrs %{
    attributes: %{},
    author_type: "some author_type",
    body: "some body",
    event: %{},
    message_type: "some message_type",
    raw_body: "some raw_body",
    user_context: %{}
  }
  @update_attrs %{
    attributes: %{},
    author_type: "some updated author_type",
    body: "some updated body",
    event: %{},
    message_type: "some updated message_type",
    raw_body: "some updated raw_body",
    user_context: %{}
  }
  @invalid_attrs %{attributes: nil, author_type: nil, body: nil, event: nil, message_type: nil, raw_body: nil, user_context: nil}

  def fixture(:message) do
    {:ok, message} = Messages.create_message(@create_attrs)
    message
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all messages", %{conn: conn} do
      conn = get(conn, Routes.message_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create message" do
    test "renders message when data is valid", %{conn: conn} do
      conn = post(conn, Routes.message_path(conn, :create), message: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.message_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => %{},
               "author_type" => "some author_type",
               "body" => "some body",
               "event" => %{},
               "message_type" => "some message_type",
               "raw_body" => "some raw_body",
               "user_context" => %{}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.message_path(conn, :create), message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update message" do
    setup [:create_message]

    test "renders message when data is valid", %{conn: conn, message: %Message{id: id} = message} do
      conn = put(conn, Routes.message_path(conn, :update, message), message: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.message_path(conn, :show, id))

      assert %{
               "id" => id,
               "attributes" => {},
               "author_type" => "some updated author_type",
               "body" => "some updated body",
               "event" => {},
               "message_type" => "some updated message_type",
               "raw_body" => "some updated raw_body",
               "user_context" => {}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, message: message} do
      conn = put(conn, Routes.message_path(conn, :update, message), message: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete message" do
    setup [:create_message]

    test "deletes chosen message", %{conn: conn, message: message} do
      conn = delete(conn, Routes.message_path(conn, :delete, message))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.message_path(conn, :show, message))
      end
    end
  end

  defp create_message(_) do
    message = fixture(:message)
    {:ok, message: message}
  end
end
