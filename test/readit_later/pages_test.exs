defmodule ReaditLater.PagesTest do
  use ReaditLater.DataCase

  alias ReaditLater.Pages

  describe "web_pages" do
    alias ReaditLater.Pages.WebPage

    @valid_attrs %{content: "some content", notes: "some notes", url: "some url"}
    @update_attrs %{content: "some updated content", notes: "some updated notes", url: "some updated url"}
    @invalid_attrs %{content: nil, notes: nil, url: nil}

    def web_page_fixture(attrs \\ %{}) do
      {:ok, web_page} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Pages.create_web_page()

      web_page
    end

    test "list_web_pages/0 returns all web_pages" do
      web_page = web_page_fixture()
      assert Pages.list_web_pages() == [web_page]
    end

    test "get_web_page!/1 returns the web_page with given id" do
      web_page = web_page_fixture()
      assert Pages.get_web_page!(web_page.id) == web_page
    end

    test "create_web_page/1 with valid data creates a web_page" do
      assert {:ok, %WebPage{} = web_page} = Pages.create_web_page(@valid_attrs)
      assert web_page.content == "some content"
      assert web_page.notes == "some notes"
      assert web_page.url == "some url"
    end

    test "create_web_page/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pages.create_web_page(@invalid_attrs)
    end

    test "update_web_page/2 with valid data updates the web_page" do
      web_page = web_page_fixture()
      assert {:ok, %WebPage{} = web_page} = Pages.update_web_page(web_page, @update_attrs)
      assert web_page.content == "some updated content"
      assert web_page.notes == "some updated notes"
      assert web_page.url == "some updated url"
    end

    test "update_web_page/2 with invalid data returns error changeset" do
      web_page = web_page_fixture()
      assert {:error, %Ecto.Changeset{}} = Pages.update_web_page(web_page, @invalid_attrs)
      assert web_page == Pages.get_web_page!(web_page.id)
    end

    test "delete_web_page/1 deletes the web_page" do
      web_page = web_page_fixture()
      assert {:ok, %WebPage{}} = Pages.delete_web_page(web_page)
      assert_raise Ecto.NoResultsError, fn -> Pages.get_web_page!(web_page.id) end
    end

    test "change_web_page/1 returns a web_page changeset" do
      web_page = web_page_fixture()
      assert %Ecto.Changeset{} = Pages.change_web_page(web_page)
    end
  end
end
