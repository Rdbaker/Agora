defmodule Agora.Repo.Migrations.CreateEndUsers do
  use Ecto.Migration

  def change do
    create table(:end_users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :username, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:end_users, [:username])
  end
end
