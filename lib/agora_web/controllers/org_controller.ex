defmodule AgoraWeb.OrgController do
  use AgoraWeb, :controller

  alias Agora.Accounts
  alias Agora.Messages

  def show_from_client_id(conn, %{"client_id" => client_id}) do
    case Accounts.get_org_by_client_id(client_id) do
      {:ok, org} ->
        conversations = Messages.list_conversations(org.id)
        render(conn, "widget.json", %{ org: org, conversations: conversations })
      {:error, _} ->
        conn
        |> AgoraWeb.FallbackController.call({:error, :not_found})
    end
  end
end
