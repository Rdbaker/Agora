defmodule AgoraWeb.MessageController do
  use AgoraWeb, :controller

  alias Agora.Messages
  alias Agora.Messages.Message
  alias Agora.Messages.Location

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
        ip: to_string(conn.assigns[:ip]),
        location: Location.location_from_ip(conn.assigns[:ip]),
      }),
      attributes: Map.get(message_params, "attributes", %{}),
      body: Map.get(message_params, "body", ""),
      raw_body: Map.get(message_params, "body", ""),
      message_type: Map.get(message_params, "message_type", "CHAT")
    }
    with {:ok, %Message{} = message} <- Messages.create_message(coerced_message_params, id) do
      # TODO: clean this up
      AgoraWeb.Endpoint.broadcast("conversation:" <> id, "agora:new_message", %{
        id: message.id,
        message_type: message.message_type,
        body: message.body,
        raw_body: message.raw_body,
        author_type: message.author_type,
        author_id: message.author_id,
        attributes: message.attributes,
        user_context: message.user_context,
        created_at: message.inserted_at,
        event: message.event,
        conversation_id: id
      })

      conn
      |> put_status(:created)
      |> render("show.json", message: message)
    end
  end

  def create_as_user(conn, %{"message" => message_params, "id" => id}) do
    coerced_message_params = %{
      author_id: conn.assigns[:current_user].id,
      author_type: "USER",
      user_context: Map.get(message_params, "user_context", %{}),
      attributes: Map.get(message_params, "attributes", %{}),
      body: Map.get(message_params, "body", ""),
      raw_body: Map.get(message_params, "body", ""),
      message_type: Map.get(message_params, "message_type", "CHAT")
    }
    with {:ok, %Message{} = message} <- Messages.create_message(coerced_message_params, id) do
      # TODO: clean this up
      AgoraWeb.Endpoint.broadcast("conversation:" <> id, "agora:new_message", %{
        id: message.id,
        message_type: message.message_type,
        body: message.body,
        raw_body: message.raw_body,
        author_type: message.author_type,
        author_id: message.author_id,
        attributes: message.attributes,
        user_context: message.user_context,
        created_at: message.inserted_at,
        event: message.event,
        conversation_id: id
      })

      conn
      |> put_status(:created)
      |> render("show.json", message: message)
    end
  end


end
