defmodule ReaditLater.Repo.Migrations.CreateWebPages do
  use Ecto.Migration

  def change do
    create table(:web_pages) do
      add :url, :string
      add :content, :text
      add :notes, :text

      timestamps()
    end

  end
end
