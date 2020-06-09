defmodule ReaditLater.Repo.Migrations.MakeTagTitleUnique do
  use Ecto.Migration

  def change do
    create unique_index(:tags, [:title, :user_id])
  end
end
