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
    plug Agora.Plug.PublicIp
  end

  scope "/", AgoraWeb do
    pipe_through :api

    get "/healthcheck", HealthCheckController, :index
  end

  # AUTH REQUIRED API ENDPOINTS
  scope "/api", AgoraWeb do
    pipe_through [:api, :user_auth]

    get "/orgs/me", OrgController, :me
    get "/org_properties/me", OrgPropertyController, :me
    get "/users/me", UserController, :me
    get "/users/:id", UserController, :show
  end

  # PUBLIC API ENDPOINTS
  scope "/api", AgoraWeb do
    pipe_through :api

    post "/users", UserController, :create
    post "/sessions", SessionController, :create
    get "/sessions", SessionController, :create
  end

  # AUTH REQUIRED WIDGET ENDPOINTS
  scope "/widget", AgoraWeb do
    pipe_through [:api, :end_user_auth]

    post "/conversations/:id/messages", MessageController, :create
    get "/end_users/me", EndUserController, :me
  end

  # PUBLIC WIDGET ENDPOINTS
  scope "/widget", AgoraWeb do
    pipe_through :api

    get "/orgs/:client_id", OrgController, :show_from_client_id
    options "/orgs/:client_id", OrgController, :options
    get "/end_users", EndUserController, :show
    get "/end_users/:id", EndUserController, :show
    get "/conversations/:id/messages", MessageController, :paginate
    post "/end_users", EndUserController, :create
    post "/sessions", SessionController, :create
    get "/sessions", SessionController, :create
  end
end
