defmodule AgoraWeb.EndUserController do
  use AgoraWeb, :controller

  alias Agora.Accounts
  alias Agora.Accounts.EndUser

  def create(conn, %{"end_user" => end_user_params}) do
    case Accounts.create_end_user(end_user_params) do
      {:ok, _end_user} ->
        conn
        |> redirect(to: Routes.session_path(conn, :create, %{ end_user: end_user_params }))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    end_user = Accounts.get_end_user!(id)
    render(conn, "show.json", end_user: end_user)
  end

  def me(conn, _params) do
    render(conn, "show.json", end_user: conn.assigns[:current_user])
  end

  # def update(conn, %{"id" => id, "end_user" => end_user_params}) do
  #   end_user = Accounts.get_end_user!(id)

  #   case Accounts.update_end_user(end_user, end_user_params) do
  #     {:ok, end_user} ->
  #       conn
  #       |> put_flash(:info, "End user updated successfully.")
  #       |> redirect(to: Routes.end_user_path(conn, :show, end_user))

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", end_user: end_user, changeset: changeset)
  #   end
  # end
end
