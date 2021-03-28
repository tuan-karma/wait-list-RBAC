defmodule WaitList.Repo.Migrations.CreateRules do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:rules, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :role, :citext, null: false
      add :resource, :citext, null: false
      add :permissions, {:array, :citext}

      timestamps()
    end

    create index(:rules, [:role])
    create unique_index(:rules, [:role, :resource])
  end
end
