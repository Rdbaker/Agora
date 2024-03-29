defmodule AgoraWeb.OrgPropertyView do
  use AgoraWeb, :view
  alias AgoraWeb.OrgPropertyView

  def render("show.json", %{org_properties: org_properties}) do
    %{data: render_many(org_properties, OrgPropertyView, "property.json")}
  end

  def render("property.json", %{org_property: property}) do
    %{
      name: property.name,
      namespace: property.namespace,
      value: property.value,
      type: property.type
    }
  end
end
