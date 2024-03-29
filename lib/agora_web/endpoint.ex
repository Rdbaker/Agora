defmodule AgoraWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :agora

  socket "/socket", AgoraWeb.UserSocket,
    # heroku has a 55 second timeout window, change this to websocket: true when we get off heroku
    websocket: [timeout: 45_000],
    longpoll: false

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :agora,
    gzip: false,
    only: ~w(css fonts images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_agora_key",
    signing_salt: "CDSGtsmG"

  plug CORSPlug, origin: ["http://lcl.agorachat.org:3200", "http://lcl.agorachat.org:9001", "https://js.agorachat.org", "https://app.agorachat.org", "https://www.agorachat.org"], headers: [
    "X-Agora-Client-Id",
    "Authorization",
    "Content-Type",
    "Accept",
    "Origin",
    "User-Agent",
    "DNT",
    "Cache-Control",
    "X-Mx-ReqToken",
    "Keep-Alive",
    "X-Requested-With",
    "If-Modified-Since",
    "X-CSRF-Token"
  ]
  plug AgoraWeb.Router
end
