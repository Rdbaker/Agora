defmodule AgoraWeb.MessageView do
  use AgoraWeb, :view
  alias AgoraWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("list.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      message_type: message.message_type,
      body: message.body,
      raw_body: message.raw_body,
      author_type: message.author_type,
      author_id: message.author_id,
      attributes: message.attributes,
      user_context: message.user_context,
      event: message.event}
  end
end
