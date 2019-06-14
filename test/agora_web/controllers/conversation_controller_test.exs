defmodule AgoraWeb.ConversationControllerTest do
  use AgoraWeb.ConnCase

  alias Agora.Message
  alias Agora.Message.Conversation

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:conversation) do
    {:ok, conversation} = Message.create_conversation(@create_attrs)
    conversation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all conversations", %{conn: conn} do
      conn = get(conn, Routes.conversation_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create conversation" do
    test "renders conversation when data is valid", %{conn: conn} do
      conn = post(conn, Routes.conversation_path(conn, :create), conversation: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.conversation_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.conversation_path(conn, :create), conversation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update conversation" do
    setup [:create_conversation]

    test "renders conversation when data is valid", %{conn: conn, conversation: %Conversation{id: id} = conversation} do
      conn = put(conn, Routes.conversation_path(conn, :update, conversation), conversation: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.conversation_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, conversation: conversation} do
      conn = put(conn, Routes.conversation_path(conn, :update, conversation), conversation: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete conversation" do
    setup [:create_conversation]

    test "deletes chosen conversation", %{conn: conn, conversation: conversation} do
      conn = delete(conn, Routes.conversation_path(conn, :delete, conversation))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.conversation_path(conn, :show, conversation))
      end
    end
  end

  defp create_conversation(_) do
    conversation = fixture(:conversation)
    {:ok, conversation: conversation}
  end
end
