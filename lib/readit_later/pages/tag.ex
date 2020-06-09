defmodule ReaditLater.Pages.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :title, :string
    belongs_to :user, ReaditLater.Account.User
    many_to_many :web_pages, ReaditLater.Pages.WebPage, join_through: "web_page_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end

end
