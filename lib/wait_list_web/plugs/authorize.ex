defmodule WaitListWeb.Authorize do
  import Plug.Conn
  import Phoenix.Controller

  alias WaitList.Authorization
  alias WaitListWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, opts) do
    role = conn.assigns.current_user.role
    resource = Keyword.get(opts, :resource)
    action = action_name(conn)

    check(action, role, resource)
    |> maybe_continue(conn)
  end

  defp maybe_continue(true, conn), do: conn

  defp maybe_continue(_not_true, conn) do
    redirect_path = conn.params["redirect"]["path"]

    conn
    |> put_flash(:error, "You're not authorized to do that!")
    |> redirect(to: redirect_path || Routes.page_path(conn, :index))
    |> halt()

    # status 403
  end

  defp check(:index, role, resource) do
    Authorization.can?(role, "Read", resource)
  end

  defp check(action, role, resource) when action in [:new, :create] do
    Authorization.can?(role, "Create", resource)
  end

  defp check(action, role, resource) when action in [:edit, :update] do
    Authorization.can?(role, "Update", resource)
  end

  defp check(:delete, role, resource) do
    Authorization.can?(role, "Delete", resource)
  end

  defp check(_action, _role, _resource), do: false
end
