defmodule TodoBackend.Repo.Migrations.MigrateTodoToUuid do
  use Ecto.Migration

  def change do
    drop table(:todos)

    create table(:todos, primary_key: false) do
      add :uuid, :uuid, primary_key: true
      add :title, :string
      add :completed, :boolean, default: false, null: false
      add :order, :integer, default: 0

      timestamps()
    end
  end
end
