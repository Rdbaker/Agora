defmodule AgoraWeb.HealthCheckView do
  use AgoraWeb, :view

  def render("index.json", _params) do
    %{status: :ok}
  end
end
