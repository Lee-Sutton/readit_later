defmodule ReaditLater.PagesTest do
  use ReaditLater.DataCase

  alias ReaditLater.Pages
  import ReaditLater.AccountFixtures

  describe "web_pages" do
    alias ReaditLater.Pages.WebPage

    @valid_attrs %{content: "some content", notes: "some notes", url: "https://valid-url.com", tags: "tag1,tag2"}
    @update_attrs %{content: "some updated content", notes: "some updated notes", url: "updated-url.com"}
    @invalid_attrs %{content: nil, notes: nil, url: nil}

    setup do
      %{user: user_fixture()}
    end

    def web_page_fixture(user, attrs \\ %{}) do
      {:ok, web_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pages.create_web_page(user)

      web_page
    end

    test "list_web_pages/0 returns all web_pages", %{user: user} do
      web_page = web_page_fixture(user)
      assert Pages.list_user_web_pages(user) == [web_page]
    end

    test "get_web_page!/1 returns the web_page with given id", %{user: user} do
      web_page = web_page_fixture(user)
      assert Pages.get_user_web_page!(user, web_page.id) == web_page
    end

    @tag :wip
    test "create_web_page/1 with valid data creates a web_page with nested tags", %{user: user} do
      assert {:ok, %WebPage{} = web_page} = Pages.create_web_page(@valid_attrs, user)
      assert web_page.content == "some content"
      assert web_page.notes == "some notes"
      assert web_page.url == "https://valid-url.com"
      Enum.each(web_page.tags, fn %ReaditLater.Pages.Tag{} = tag -> assert name end)
      assert web_page.tags == ["tag1", "tag2"]
    end

    test "create_web_page/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Pages.create_web_page(@invalid_attrs, user)
    end

    test "only valid urls are accepted", %{user: user} do
      web_page = Map.merge(@valid_attrs, %{url: "invalid url"})
      assert {:error, %Ecto.Changeset{}} = Pages.create_web_page(web_page, user)
    end

    test "update_web_page/2 with valid data updates the web_page", %{user: user} do
      web_page = web_page_fixture(user)
      assert {:ok, %WebPage{} = web_page} = Pages.update_web_page(web_page, user, @update_attrs)
      assert web_page.content == "some updated content"
      assert web_page.notes == "some updated notes"
      assert web_page.url == "updated-url.com"
    end

    test "update_web_page/2 with invalid data returns error changeset", %{user: user} do
      web_page = web_page_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Pages.update_web_page(web_page, user, @invalid_attrs)
      assert web_page == Pages.get_user_web_page!(user, web_page.id)
    end

    test "delete_web_page/1 deletes the web_page", %{user: user} do
      web_page = web_page_fixture(user)
      assert {:ok, %WebPage{}} = Pages.delete_web_page(web_page)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_user_web_page!(user, web_page.id) end
    end

    test "change_web_page/1 returns a web_page changeset", %{user: user} do
      web_page = web_page_fixture(user)
      assert %Ecto.Changeset{} = Pages.change_web_page(web_page)
    end
  end
end
