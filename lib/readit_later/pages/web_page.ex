defmodule ReaditLater.Pages.WebPage do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias ReaditLater.Repo

  schema "web_pages" do
    field :content, :string
    field :notes, :string
    field :url, :string
    belongs_to :user, ReaditLater.Account.User
    many_to_many :tags, ReaditLater.Pages.Tag, join_through: "web_page_tags"

    timestamps()
  end

  @doc false
  def changeset(web_page, user, attrs) do
    web_page
    |> cast(attrs, [:url, :content, :notes])
    |> validate_required([:url])
    |> Ecto.Changeset.put_assoc(:tags, parse_tags(user, attrs))
  end

  defp parse_tags(user, params) do
    (params["tags"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(fn x -> x == "" end)
    |> insert_and_get_all(user)
  end

  defp insert_and_get_all([], _) do
    []
  end

  defp insert_and_get_all(tag_titles, user) do
    maps =
      Enum.map(
        tag_titles,
        &%{title: &1, user_id: user.id, inserted_at: NaiveDateTime.local_now(), updated_at: NaiveDateTime.local_now()}
      )

    Repo.insert_all(ReaditLater.Pages.Tag, maps, on_conflict: :nothing)
    Repo.all(from t in ReaditLater.Pages.Tag, where: t.title in ^tag_titles)
  end
end
