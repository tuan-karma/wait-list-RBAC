defmodule WaitListWeb.PartyControllerTest do
  use WaitListWeb.ConnCase

  alias WaitList.Reservation

  @create_attrs %{name: "some name", size: 42, status: "some status"}
  @update_attrs %{name: "some updated name", size: 43, status: "some updated status"}
  @invalid_attrs %{name: nil, size: nil, status: nil}

  def fixture(:party) do
    {:ok, party} = Reservation.create_party(@create_attrs)
    party
  end

  describe "index" do
    test "lists all parties", %{conn: conn} do
      conn = get(conn, Routes.party_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Parties"
    end
  end

  describe "new party" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.party_path(conn, :new))
      assert html_response(conn, 200) =~ "New Party"
    end
  end

  describe "create party" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.party_path(conn, :create), party: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.party_path(conn, :show, id)

      conn = get(conn, Routes.party_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Party"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.party_path(conn, :create), party: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Party"
    end
  end

  describe "edit party" do
    setup [:create_party]

    test "renders form for editing chosen party", %{conn: conn, party: party} do
      conn = get(conn, Routes.party_path(conn, :edit, party))
      assert html_response(conn, 200) =~ "Edit Party"
    end
  end

  describe "update party" do
    setup [:create_party]

    test "redirects when data is valid", %{conn: conn, party: party} do
      conn = put(conn, Routes.party_path(conn, :update, party), party: @update_attrs)
      assert redirected_to(conn) == Routes.party_path(conn, :show, party)

      conn = get(conn, Routes.party_path(conn, :show, party))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, party: party} do
      conn = put(conn, Routes.party_path(conn, :update, party), party: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Party"
    end
  end

  describe "delete party" do
    setup [:create_party]

    test "deletes chosen party", %{conn: conn, party: party} do
      conn = delete(conn, Routes.party_path(conn, :delete, party))
      assert redirected_to(conn) == Routes.party_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.party_path(conn, :show, party))
      end
    end
  end

  defp create_party(_) do
    party = fixture(:party)
    %{party: party}
  end
end
