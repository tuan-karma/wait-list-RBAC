defmodule WaitList.Authorization.Rule do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  # @permissions ~w(Create Read Update Delete)
  schema "rules" do
    field :permissions, {:array, :string}
    field :resource, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(rule, attrs) do
    rule
    |> cast(attrs, [:role, :resource, :permissions])
    |> validate_required([:role, :resource])

    # |> validate_inclusion(:permissions, @permissions)
  end
end
