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
    |> validate_url(:url)
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
        &%{
          title: &1,
          user_id: user.id,
          inserted_at: NaiveDateTime.local_now(),
          updated_at: NaiveDateTime.local_now()
        }
      )

    Repo.insert_all(ReaditLater.Pages.Tag, maps, on_conflict: :nothing)
    Repo.all(from t in ReaditLater.Pages.Tag, where: t.title in ^tag_titles)
  end

  defp validate_url(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, url ->
      uri =
        url
        |> prepend_url_scheme()
        |> URI.parse()

      case uri.scheme != nil && uri.host =~ "." do
        true -> []
        false -> [{field, options[:message] || "Invalid url"}]
      end
    end)
  end

  defp prepend_url_scheme(url) do
    case String.contains?(url, ["http://", "https://"]) do
      true -> url
      false -> "https://#{url}"
    end
  end
end
