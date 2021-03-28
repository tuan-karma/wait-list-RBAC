defmodule WaitListWeb.RuleController do
  use WaitListWeb, :controller

  alias WaitList.Authorization
  alias WaitList.Authorization.Rule

  def index(conn, _params) do
    rules = Authorization.list_rules()
    render(conn, "index.html", rules: rules)
  end

  def new(conn, _params) do
    changeset = Authorization.change_rule(%Rule{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rule" => rule_params}) do
    case Authorization.create_rule(rule_params) do
      {:ok, rule} ->
        conn
        |> put_flash(:info, "Rule created successfully.")
        |> redirect(to: Routes.rule_path(conn, :show, rule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rule =
      Authorization.get_rule!(id)
      |> IO.inspect(label: "RULE@show")

    render(conn, "show.html", rule: rule)
  end

  def edit(conn, %{"id" => id}) do
    rule = Authorization.get_rule!(id)
    changeset = Authorization.change_rule(rule)
    render(conn, "edit.html", rule: rule, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rule" => rule_params}) do
    rule = Authorization.get_rule!(id)

    case Authorization.update_rule(rule, rule_params) do
      {:ok, rule} ->
        conn
        |> put_flash(:info, "Rule updated successfully.")
        |> redirect(to: Routes.rule_path(conn, :show, rule))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rule: rule, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rule = Authorization.get_rule!(id)
    {:ok, _rule} = Authorization.delete_rule(rule)

    conn
    |> put_flash(:info, "Rule deleted successfully.")
    |> redirect(to: Routes.rule_path(conn, :index))
  end
end
