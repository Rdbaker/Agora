defmodule AgoraWeb.SessionController do
  use AgoraWeb, :controller

  alias Agora.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"end_user" => %{"username" => username, "password" => password}}) do
    case Accounts.authenticate_by_username_password(username, password) do
      {:ok, end_user} ->
        case Agora.Guardian.encode_and_sign(end_user, %{}, token_type: :widget) do
          {:ok, token, claims} ->
            render(conn, "show.json", %{ token: token, claims: claims })
        end
      {:error, :unauthorized} ->
        conn
        |> put_status(400)
        |> render("error.json", %{ errors: %{ username: ["and password not recognized"] }})
    end
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        case Agora.Guardian.encode_and_sign(user) do
          {:ok, token, claims} ->
            render(conn, "show.json", %{ token: token, claims: claims })
        end
      {:error, :unauthorized} ->
        render(conn, "error.json", %{ error: "unauthorized" })
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
