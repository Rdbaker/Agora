defmodule AgoraWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use AgoraWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AgoraWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(AgoraWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, _}) do
    conn
    |> put_status(:internal_error)
    |> put_view(AgoraWeb.ErrorView)
    |> render(:"500")
  end
end
