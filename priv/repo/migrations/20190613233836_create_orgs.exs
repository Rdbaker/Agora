defmodule Agora.Repo.Migrations.CreateOrgs do
  use Ecto.Migration

  def change do
    create table(:orgs) do

      timestamps()
    end

  end
end
