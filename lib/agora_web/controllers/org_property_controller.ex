defmodule AgoraWeb.OrgPropertyController do
  use AgoraWeb, :controller

  alias Agora.Accounts

  def me(conn, _params) do
    render(conn, "show.json", org_properties: Accounts.get_properties_for_org(conn.assigns[:current_user].org_id))
  end
end
