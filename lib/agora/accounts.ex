defmodule Agora.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Agora.Repo

  alias Agora.Accounts.User
  alias Agora.Accounts.EndUser

  def authenticate_by_email_password(email, password) do
    user = Repo.get_by(User, email: email)
    case Bcrypt.check_pass(user, password) do
      {:ok, _} -> {:ok, user}
      {:error, _} -> {:error, :unauthorized}
    end
  end

  def authenticate_by_username_password(username, password) do
    end_user = Repo.get_by(EndUser, username: username)
    case Bcrypt.check_pass(end_user, password) do
      {:ok, _} -> {:ok, end_user}
      {:error, _} -> {:error, :unauthorized}
    end
  end



  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @doc """
  Returns the list of end_users.

  ## Examples

      iex> list_end_users()
      [%EndUser{}, ...]

  """
  def list_end_users do
    Repo.all(EndUser)
  end

  @doc """
  Gets a single end_user.

  Raises `Ecto.NoResultsError` if the End user does not exist.

  ## Examples

      iex> get_end_user!(123)
      %EndUser{}

      iex> get_end_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_end_user!(id), do: Repo.get!(EndUser, id)

  @doc """
  Creates a end_user.

  ## Examples

      iex> create_end_user(%{field: value})
      {:ok, %EndUser{}}

      iex> create_end_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_end_user(attrs \\ %{}) do
    %EndUser{}
    |> EndUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a end_user.

  ## Examples

      iex> update_end_user(end_user, %{field: new_value})
      {:ok, %EndUser{}}

      iex> update_end_user(end_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_end_user(%EndUser{} = end_user, attrs) do
    end_user
    |> EndUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a EndUser.

  ## Examples

      iex> delete_end_user(end_user)
      {:ok, %EndUser{}}

      iex> delete_end_user(end_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_end_user(%EndUser{} = end_user) do
    Repo.delete(end_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking end_user changes.

  ## Examples

      iex> change_end_user(end_user)
      %Ecto.Changeset{source: %EndUser{}}

  """
  def change_end_user(%EndUser{} = end_user) do
    EndUser.changeset(end_user, %{})
  end
end
