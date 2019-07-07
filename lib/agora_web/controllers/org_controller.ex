defmodule AgoraWeb.OrgController do
  use AgoraWeb, :controller

  alias Agora.Accounts
  alias Agora.Messages

  def me(conn, _params) do
    org = Accounts.get_org! conn.assigns[:current_user].org_id
    conversations = Messages.list_conversations(org.id)
    org_properties = Accounts.get_properties_for_org(org.id)
    render(conn, "private.json", %{ org: org, conversations: conversations, org_properties: org_properties })
  end

  def show_from_client_id(conn, %{"client_id" => client_id}) do
    case Accounts.get_org_by_client_id(client_id) do
      {:ok, org} ->
        conversations = Messages.list_conversations(org.id)
        org_properties = Accounts.get_properties_for_org(org.id)
        render(conn, "widget.json", %{ org: org, conversations: conversations, org_properties: org_properties })
      {:error, _} ->
        conn
        |> AgoraWeb.FallbackController.call({:error, :not_found})
    end
  end
end
