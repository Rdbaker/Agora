defmodule Agora.Repo.Migrations.AddOrgIdToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :org_id, references(:orgs)
    end
  end
end
