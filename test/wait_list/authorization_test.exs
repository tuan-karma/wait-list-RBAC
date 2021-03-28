defmodule WaitList.AuthorizationTest do
  use WaitList.DataCase

  alias WaitList.Authorization

  describe "rules" do
    alias WaitList.Authorization.Rule

    @valid_attrs %{permissions: [], resource: "some resource", role: "some role"}
    @update_attrs %{permissions: [], resource: "some updated resource", role: "some updated role"}
    @invalid_attrs %{permissions: nil, resource: nil, role: nil}

    def rule_fixture(attrs \\ %{}) do
      {:ok, rule} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authorization.create_rule()

      rule
    end

    test "list_rules/0 returns all rules" do
      rule = rule_fixture()
      assert Authorization.list_rules() == [rule]
    end

    test "get_rule!/1 returns the rule with given id" do
      rule = rule_fixture()
      assert Authorization.get_rule!(rule.id) == rule
    end

    test "create_rule/1 with valid data creates a rule" do
      assert {:ok, %Rule{} = rule} = Authorization.create_rule(@valid_attrs)
      assert rule.permissions == []
      assert rule.resource == "some resource"
      assert rule.role == "some role"
    end

    test "create_rule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authorization.create_rule(@invalid_attrs)
    end

    test "update_rule/2 with valid data updates the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{} = rule} = Authorization.update_rule(rule, @update_attrs)
      assert rule.permissions == []
      assert rule.resource == "some updated resource"
      assert rule.role == "some updated role"
    end

    test "update_rule/2 with invalid data returns error changeset" do
      rule = rule_fixture()
      assert {:error, %Ecto.Changeset{}} = Authorization.update_rule(rule, @invalid_attrs)
      assert rule == Authorization.get_rule!(rule.id)
    end

    test "delete_rule/1 deletes the rule" do
      rule = rule_fixture()
      assert {:ok, %Rule{}} = Authorization.delete_rule(rule)
      assert_raise Ecto.NoResultsError, fn -> Authorization.get_rule!(rule.id) end
    end

    test "change_rule/1 returns a rule changeset" do
      rule = rule_fixture()
      assert %Ecto.Changeset{} = Authorization.change_rule(rule)
    end
  end
end
