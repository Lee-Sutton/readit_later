defmodule ReaditLater.Repo.Migrations.RemoveWebPageTagsTimestamps do
  use Ecto.Migration

  def change do
    alter table(:web_page_tags) do
      remove :inserted_at
      remove :updated_at
    end
  end
end
