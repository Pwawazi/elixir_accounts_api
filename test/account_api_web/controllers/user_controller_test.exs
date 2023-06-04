defmodule AccountApiWeb.UserControllerTest do
  use AccountApiWeb.ConnCase

  import AccountApi.UsersFixtures

  alias AccountApi.Users.User

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    phone_number: "some phone_number",
    gender: "some gender",
    biography: "some biography"
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    phone_number: "some updated phone_number",
    gender: "some updated gender",
    biography: "some updated biography"
  }
  @invalid_attrs %{first_name: nil, last_name: nil, phone_number: nil, gender: nil, biography: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some biography",
               "first_name" => "some first_name",
               "gender" => "some gender",
               "last_name" => "some last_name",
               "phone_number" => "some phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "biography" => "some updated biography",
               "first_name" => "some updated first_name",
               "gender" => "some updated gender",
               "last_name" => "some updated last_name",
               "phone_number" => "some updated phone_number"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
