defmodule ReaditLaterWeb.WebPageControllerTest do
  use ReaditLaterWeb.ConnCase

  alias ReaditLater.Pages

  @create_attrs %{content: "some content", notes: "some notes", url: "some url"}
  @update_attrs %{content: "some updated content", notes: "some updated notes", url: "some updated url"}
  @invalid_attrs %{content: nil, notes: nil, url: nil}

  def fixture(:web_page) do
    {:ok, web_page} = Pages.create_web_page(@create_attrs)
    web_page
  end

  describe "index" do
    test "lists all web_pages", %{conn: conn} do
      conn = get(conn, Routes.web_page_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Web pages"
    end
  end

  describe "new web_page" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.web_page_path(conn, :new))
      assert html_response(conn, 200) =~ "New Web page"
    end
  end

  describe "create web_page" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.web_page_path(conn, :create), web_page: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.web_page_path(conn, :show, id)

      conn = get(conn, Routes.web_page_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Web page"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.web_page_path(conn, :create), web_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Web page"
    end
  end

  describe "edit web_page" do
    setup [:create_web_page]

    test "renders form for editing chosen web_page", %{conn: conn, web_page: web_page} do
      conn = get(conn, Routes.web_page_path(conn, :edit, web_page))
      assert html_response(conn, 200) =~ "Edit Web page"
    end
  end

  describe "update web_page" do
    setup [:create_web_page]

    test "redirects when data is valid", %{conn: conn, web_page: web_page} do
      conn = put(conn, Routes.web_page_path(conn, :update, web_page), web_page: @update_attrs)
      assert redirected_to(conn) == Routes.web_page_path(conn, :show, web_page)

      conn = get(conn, Routes.web_page_path(conn, :show, web_page))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, web_page: web_page} do
      conn = put(conn, Routes.web_page_path(conn, :update, web_page), web_page: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Web page"
    end
  end

  describe "delete web_page" do
    setup [:create_web_page]

    test "deletes chosen web_page", %{conn: conn, web_page: web_page} do
      conn = delete(conn, Routes.web_page_path(conn, :delete, web_page))
      assert redirected_to(conn) == Routes.web_page_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.web_page_path(conn, :show, web_page))
      end
    end
  end

  defp create_web_page(_) do
    web_page = fixture(:web_page)
    %{web_page: web_page}
  end
end
