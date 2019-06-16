defmodule Agora.ConversationChannel do
  use AgoraWeb, :channel

  def join("conversation:" <> conversation_id, _params, socket) do
    {:ok, %{}, socket}
  end

  def handle_in() do

  end
end
