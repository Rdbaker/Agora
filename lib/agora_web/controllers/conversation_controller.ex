defmodule AgoraWeb.ConversationController do
  use AgoraWeb, :controller

  alias Agora.Message
  alias Agora.Message.Conversation

  action_fallback AgoraWeb.FallbackController

  def index(conn, _params) do
    conversations = Message.list_conversations()
    render(conn, "index.json", conversations: conversations)
  end

  def create(conn, %{"conversation" => conversation_params}) do
    with {:ok, %Conversation{} = conversation} <- Message.create_conversation(conversation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.conversation_path(conn, :show, conversation))
      |> render("show.json", conversation: conversation)
    end
  end

  def show(conn, %{"id" => id}) do
    conversation = Message.get_conversation!(id)
    render(conn, "show.json", conversation: conversation)
  end

  def update(conn, %{"id" => id, "conversation" => conversation_params}) do
    conversation = Message.get_conversation!(id)

    with {:ok, %Conversation{} = conversation} <- Message.update_conversation(conversation, conversation_params) do
      render(conn, "show.json", conversation: conversation)
    end
  end

  def delete(conn, %{"id" => id}) do
    conversation = Message.get_conversation!(id)

    with {:ok, %Conversation{}} <- Message.delete_conversation(conversation) do
      send_resp(conn, :no_content, "")
    end
  end
end
