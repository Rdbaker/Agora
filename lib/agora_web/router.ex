defmodule AgoraWeb.Router do
  use AgoraWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :user_auth do
    plug Agora.Auth.UserTokenPlug
  end

  pipeline :end_user_auth do
    plug Agora.Auth.EndUserTokenPlug
  end

  scope "/", AgoraWeb do
    pipe_through :api

    get "/healthcheck", HealthCheckController, :index
  end

  scope "/api", AgoraWeb do
    pipe_through [:api, :user_auth]

    get "/users/me", UserController, :me
  end

  scope "/api", AgoraWeb do
    pipe_through [:api, :end_user_auth]

    get "/end_users/me", EndUserController, :me
  end

  scope "/api", AgoraWeb do
    pipe_through :api

    post "/end_users", EndUserController, :create
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    post "/sessions", SessionController, :create
    get "/sessions", SessionController, :create
  end
end
