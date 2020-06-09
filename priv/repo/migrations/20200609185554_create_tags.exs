defmodule ReaditLater.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tags, [:user_id])
  end
end
