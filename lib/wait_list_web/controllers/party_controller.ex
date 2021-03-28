defmodule WaitListWeb.PartyController do
  use WaitListWeb, :controller

  alias WaitList.Reservation
  alias WaitList.Reservation.Party

  plug WaitListWeb.Authorize, resource: "Party"

  def index(conn, _params) do
    parties = Reservation.list_parties()
    changeset = Reservation.change_party(%Party{})
    render(conn, "index.html", parties: parties, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Reservation.change_party(%Party{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"party" => party_params}) do
    case Reservation.create_party(party_params) do
      {:ok, _party} ->
        conn
        |> put_flash(:info, "Party created successfully.")
        |> redirect(to: Routes.party_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    party = Reservation.get_party!(id)
    render(conn, "show.html", party: party)
  end

  def edit(conn, %{"id" => id}) do
    party = Reservation.get_party!(id)
    changeset = Reservation.change_party(party)
    render(conn, "edit.html", party: party, changeset: changeset)
  end

  def update(conn, %{"id" => id, "party" => party_params}) do
    party = Reservation.get_party!(id)

    case Reservation.update_party(party, party_params) do
      {:ok, _party} ->
        conn
        |> put_flash(:info, "Party updated successfully.")
        |> redirect(to: Routes.party_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", party: party, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    party = Reservation.get_party!(id)
    {:ok, _party} = Reservation.delete_party(party)

    conn
    |> put_flash(:info, "Party deleted successfully.")
    |> redirect(to: Routes.party_path(conn, :index))
  end
end
