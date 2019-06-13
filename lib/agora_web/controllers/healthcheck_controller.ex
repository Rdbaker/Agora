defmodule AgoraWeb.HealthCheckController do
  use AgoraWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json", %{})
  end

end
