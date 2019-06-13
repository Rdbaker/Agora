defmodule Agora.AccountsTest do
  use Agora.DataCase

  alias Agora.Accounts

  describe "users" do
    alias Agora.Accounts.User

    @valid_attrs %{email: "some email", name: "some name"}
    @update_attrs %{email: "some updated email", name: "some updated name"}
    @invalid_attrs %{email: nil, name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "end_users" do
    alias Agora.Accounts.EndUser

    @valid_attrs %{username: "some username"}
    @update_attrs %{username: "some updated username"}
    @invalid_attrs %{username: nil}

    def end_user_fixture(attrs \\ %{}) do
      {:ok, end_user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_end_user()

      end_user
    end

    test "list_end_users/0 returns all end_users" do
      end_user = end_user_fixture()
      assert Accounts.list_end_users() == [end_user]
    end

    test "get_end_user!/1 returns the end_user with given id" do
      end_user = end_user_fixture()
      assert Accounts.get_end_user!(end_user.id) == end_user
    end

    test "create_end_user/1 with valid data creates a end_user" do
      assert {:ok, %EndUser{} = end_user} = Accounts.create_end_user(@valid_attrs)
      assert end_user.username == "some username"
    end

    test "create_end_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_end_user(@invalid_attrs)
    end

    test "update_end_user/2 with valid data updates the end_user" do
      end_user = end_user_fixture()
      assert {:ok, %EndUser{} = end_user} = Accounts.update_end_user(end_user, @update_attrs)
      assert end_user.username == "some updated username"
    end

    test "update_end_user/2 with invalid data returns error changeset" do
      end_user = end_user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_end_user(end_user, @invalid_attrs)
      assert end_user == Accounts.get_end_user!(end_user.id)
    end

    test "delete_end_user/1 deletes the end_user" do
      end_user = end_user_fixture()
      assert {:ok, %EndUser{}} = Accounts.delete_end_user(end_user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_end_user!(end_user.id) end
    end

    test "change_end_user/1 returns a end_user changeset" do
      end_user = end_user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_end_user(end_user)
    end
  end
end
