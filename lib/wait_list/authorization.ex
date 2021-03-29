defmodule WaitList.Authorization do
  @moduledoc """
  The Authorization context.
  """

  import Ecto.Query, warn: false
  alias WaitList.Repo
  alias WaitList.Authorization.Rule

  # Example: Authorization.can?(role, "Read", resource)
  def can?(role, action, resource) do
    rule = Rule |> Repo.get_by(role: role, resource: resource)
    permissions = rule && Map.get(rule, :permissions)
    # return nil or true or false:
    permissions && action in permissions
  end

  ## Database getters (CRUD auto_gen)

  def list_rules do
    Repo.all(Rule)
  end

  def get_rule!(id), do: Repo.get!(Rule, id)

  def create_rule(attrs \\ %{}) do
    %Rule{}
    |> Rule.changeset(attrs)
    |> Repo.insert()
  end

  def update_rule(%Rule{} = rule, attrs) do
    rule
    |> Rule.changeset(attrs)
    |> Repo.update()
  end

  def delete_rule(%Rule{} = rule) do
    Repo.delete(rule)
  end

  def change_rule(%Rule{} = rule, attrs \\ %{}) do
    Rule.changeset(rule, attrs)
  end
end
