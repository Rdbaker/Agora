defmodule AgoraWeb.EndUserView do
  use AgoraWeb, :view
  alias AgoraWeb.EndUserView
  import AgoraWeb.ErrorHelpers

  def render("index.json", _params) do
    %{allowed: false}
  end

  def render("error.json", %{:changeset => changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  def render("show.json", %{:end_users => end_users}) do
    %{data: render_many(end_users, EndUserView, "end_user.json")}
  end

  def render("show.json", params) do
    %{data: render("end_user.json", params)}
  end

  def render("end_user.json", %{end_user: end_user}) do
    %{username: end_user.username, id: end_user.id, created_at: end_user.inserted_at}
  end
end
