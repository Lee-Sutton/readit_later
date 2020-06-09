defmodule ReaditLater.Pages do
  @moduledoc """
  The Pages context.
  """
  alias ReaditLater.Account

  import Ecto.Query, warn: false
  alias ReaditLater.Repo

  alias ReaditLater.Pages.WebPage

  @doc """
  Returns the list of web_pages.

  ## Examples

      iex> list_user_web_pages()
      [%WebPage{}, ...]

  """
  def list_user_web_pages(%Account.User{} = user) do
    WebPage
    |> user_web_page_query(user)
    |> Repo.all()
  end

  @doc """
  Gets a single web_page that belongs to the input user.

  Raises `Ecto.NoResultsError` if the web page does not exist or is not
  owned by the user

  """
  def get_user_web_page!(user, id) do
    WebPage
    |> user_web_page_query(user)
    |> preload([:tags])
    |> Repo.get!(id)
  end

  @doc """
  Creates a web_page.

  ## Examples

      iex> create_web_page(%{field: value})
      {:ok, %WebPage{}}

      iex> create_web_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_web_page(attrs \\ %{}) do
    user = attrs["user"]

    %WebPage{}
    |> WebPage.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a web_page.

  ## Examples

      iex> update_web_page(web_page, %{field: new_value})
      {:ok, %WebPage{}}

      iex> update_web_page(web_page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_web_page(%WebPage{} = web_page, attrs) do
    web_page
    |> WebPage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a web_page.

  ## Examples

      iex> delete_web_page(web_page)
      {:ok, %WebPage{}}

      iex> delete_web_page(web_page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_web_page(%WebPage{} = web_page) do
    Repo.delete(web_page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking web_page changes.

  ## Examples

      iex> change_web_page(web_page)
      %Ecto.Changeset{data: %WebPage{}}

  """
  def change_web_page(%WebPage{} = web_page, attrs \\ %{}) do
    WebPage.changeset(web_page, attrs)
  end

  defp user_web_page_query(query, %Account.User{id: user_id}) do
    from(w in query, where: w.user_id == ^user_id)
  end
end
