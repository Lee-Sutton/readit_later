defmodule ReaditLater.Repo.Migrations.MakeTagNamesUnique do
  use Ecto.Migration

  def change do
    create unique_index(:tags, [:title])
  end
end
