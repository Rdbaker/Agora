defmodule AgoraWeb.SessionController do
  use AgoraWeb, :controller

  alias Agora.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        case Agora.Guardian.encode_and_sign(user) do
          {:ok, token, claims} ->
            render(conn, "show.json", %{ token: token, claims: claims })
        end
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Bad email/password combination")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
