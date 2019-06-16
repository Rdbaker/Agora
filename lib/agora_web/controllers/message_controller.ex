defmodule AgoraWeb.MessageController do
  use AgoraWeb, :controller

  alias Agora.Messages
  alias Agora.Messages.Message

  action_fallback AgoraWeb.FallbackController

  def paginate(conn, %{"id" => conversation_id, "before" => before}) do
    messages = Messages.paginate_messages(Ecto.UUID.cast!(conversation_id), 35, before)
    render(conn, "list.json", messages: messages)
  end

  def paginate(conn, %{"id" => conversation_id}) do
    messages = Messages.paginate_messages(conversation_id, 35)
    render(conn, "list.json", messages: messages)
  end

  def create(conn, %{"message" => message_params, "id" => id}) do
    coerced_message_params = %{
      author_id: conn.assigns[:current_user].id,
      author_type: "END_USER",
      user_context: Map.merge(Map.get(message_params, "user_context", %{}), %{
        ip: to_string(:inet_parse.ntoa(conn.remote_ip)),
      }),
      attributes: Map.get(message_params, "attributes", %{}),
      body: Map.get(message_params, "body", ""),
      raw_body: Map.get(message_params, "body", ""),
      message_type: Map.get(message_params, "message_type", "CHAT")
    }
    with {:ok, %Message{} = message} <- Messages.create_message(coerced_message_params, id) do
      conn
      |> put_status(:created)
      |> render("show.json", message: message)
    end
  end

end
