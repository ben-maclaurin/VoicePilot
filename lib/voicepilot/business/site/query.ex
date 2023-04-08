defmodule Voicepilot.Business.Site.Query do
  import Ecto.Query
  alias Voicepilot.Business.Site

  def base do
    Site
  end

  def for_user(query \\ base(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end
end
