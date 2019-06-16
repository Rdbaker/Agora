defmodule Agora.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :message_type, :string
      add :body, :string
      add :raw_body, :string
      add :author_id, :string
      add :author_type, :string
      add :attributes, :map
      add :user_context, :map
      add :event, :map
      add :org_id, references(:orgs, on_delete: :nothing)
      add :conversation_id, references(:conversations, on_delete: :nothing, type: :uuid)

      timestamps()
    end

    create index(:messages, [:org_id])
    create index(:messages, [:conversation_id])
    create index(:messages, [:inserted_at])
  end
end
