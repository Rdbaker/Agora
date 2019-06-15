defmodule AgoraWeb.OrgView do
  use AgoraWeb, :view
  alias AgoraWeb.OrgView
  alias AgoraWeb.ConversationView

  def render("widget.json", %{org: org, conversations: conversations}) do
    %{data: %{
      org: render_one(org, OrgView, "org.json"),
      conversations: render_many(conversations, ConversationView, "conversation.json")
    }}
  end

  def render("org.json", %{org: org}) do
    %{id: org.id, created_at: org.inserted_at}
  end
end
