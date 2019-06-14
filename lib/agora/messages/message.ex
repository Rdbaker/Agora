defmodule Agora.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :attributes, :map
    field :author_type, :string
    field :author_id, :string
    field :body, :string
    field :event, :map
    field :message_type, :string
    field :raw_body, :string
    field :user_context, :map
    belongs_to :conversation, Agora.Messages.Conversation
    belongs_to :org, Agora.Accounts.Org

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:message_type, :raw_body, :body, :author_id, :author_type, :attributes, :user_context, :event])
    |> validate_required([:message_type, :body, :raw_body, :author_id, :author_type, :attributes, :user_context])
  end
end
