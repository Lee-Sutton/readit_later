defmodule ReaditLater.Pages.WebPage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "web_pages" do
    field :content, :string
    field :notes, :string
    field :url, :string
    belongs_to :user, ReaditLater.Account.User

    timestamps()
  end

  @doc false
  def changeset(web_page, attrs) do
    web_page
    |> cast(attrs, [:url, :content, :notes])
    |> validate_required([:url])
  end
end
