defmodule AgoraWeb.OrgView do
  use AgoraWeb, :view
  alias AgoraWeb.OrgView
  alias AgoraWeb.OrgPropertyView
  alias AgoraWeb.ConversationView

  def render("widget.json", %{org: org, conversations: conversations, org_properties: org_properties}) do
    %{data: %{
      org: render_one(org, OrgView, "org.json"),
      conversations: render_many(conversations, ConversationView, "conversation.json"),
      properties: render_many(org_properties, OrgPropertyView, "property.json")
    }}
  end

  def render("org.json", %{org: org}) do
    %{id: org.id, created_at: org.inserted_at}
  end

  def render("private.json", %{org: org}) do
    %{
      id: org.id,
      created_at: org.inserted_at,
      client_id: org.client_id,
      client_secret: org.client_secret,
    }
  end
end
