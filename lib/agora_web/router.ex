defmodule AgoraWeb.Router do
  use AgoraWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug Agora.Auth.TokenPlug
  end

  scope "/", AgoraWeb do
    pipe_through :api

    get "/healthcheck", HealthCheckController, :index
  end

  scope "/api", AgoraWeb do
    pipe_through [:api, :auth]

    get "/users/me", UserController, :me
  end

  scope "/api", AgoraWeb do
    pipe_through :api

    get "/users", UserController, :index
    post "/users", UserController, :create
    get "/users/:id", UserController, :show
    post "/sessions", SessionController, :create
    get "/sessions", SessionController, :create
  end
end
