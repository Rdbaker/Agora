defmodule Agora.Accounts.Org do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orgs" do

    timestamps()
  end

  @doc false
  def changeset(org, attrs) do
    org
    |> cast(attrs, [])
    |> validate_required([])
  end
end
