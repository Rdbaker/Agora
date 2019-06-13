defmodule AgoraWeb.EndUserView do
  import AgoraWeb.ErrorHelpers

  def render("index.json", _params) do
    %{allowed: false}
  end

  def render("error.json", %{:changeset => changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  def render("show.json", params) do
    %{data: render("end_user.json", params)}
  end

  def render("end_user.json", %{end_user: end_user}) do
    %{username: end_user.username, id: end_user.id}
  end
end
