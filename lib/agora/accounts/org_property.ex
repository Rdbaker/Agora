defmodule Agora.Accounts.OrgProperty do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  schema "org_properties" do
    field :name, :string, primary_key: true
    field :value, :string
    field :namespace, :string
    field :type, :string
    belongs_to :org, Agora.Accounts.Org, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(property, attrs) do
    property
    |> cast(attrs, [:name, :value, :type, :namespace])
    |> validate_required([:name, :value, :type, :namespace])
  end
end
