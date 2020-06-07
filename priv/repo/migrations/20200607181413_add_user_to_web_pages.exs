defmodule ReaditLater.Repo.Migrations.AddUserToWebPages do
  use Ecto.Migration

  def change do
    alter table(:web_pages) do
      add :user_id, references(:users)
    end
  end
end
