defmodule AgoraWeb.OrgController do
  use AgoraWeb, :controller

  alias Agora.Accounts
  alias Agora.Messages

  def show_from_client_id(conn, %{"client_id" => client_id}) do
    org = Accounts.get_org_by_client_id(client_id)
    conversations = Messages.list_conversations(org.id)
    render(conn, "widget.json", %{ org: org, conversations: conversations })
  end
end
