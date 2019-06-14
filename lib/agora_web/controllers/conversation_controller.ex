defmodule AgoraWeb.ConversationController do
  use AgoraWeb, :controller

  alias Agora.Messages
  alias Agora.Messages.Conversation

  action_fallback AgoraWeb.FallbackController

  def index(conn, _params) do
    conversations = Messages.list_conversations()
    render(conn, "index.json", conversations: conversations)
  end

  def create(conn, %{"conversation" => conversation_params}) do
    with {:ok, %Conversation{} = conversation} <- Messages.create_conversation(conversation_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.conversation_path(conn, :show, conversation))
      |> render("show.json", conversation: conversation)
    end
  end

  def show(conn, %{"id" => id}) do
    conversation = Messages.get_conversation!(id)
    render(conn, "show.json", conversation: conversation)
  end

  def update(conn, %{"id" => id, "conversation" => conversation_params}) do
    conversation = Messages.get_conversation!(id)

    with {:ok, %Conversation{} = conversation} <- Messages.update_conversation(conversation, conversation_params) do
      render(conn, "show.json", conversation: conversation)
    end
  end
end
