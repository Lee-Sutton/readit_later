defmodule ReaditLater.Repo.Migrations.CreateTagsWebPagesTable do
  use Ecto.Migration

  def change do
    create table(:web_page_tags, primary_key: false) do
      add(:tag_id, references(:tags, on_delete: :delete_all))
      add(:web_page_id, references(:web_pages, on_delete: :delete_all))
      timestamps()
    end

    create(index(:web_page_tags, [:tag_id]))
    create(index(:web_page_tags, [:web_page_id]))

    create(
      unique_index(:web_page_tags, [:tag_id, :web_page_id])
    )
  end
end
