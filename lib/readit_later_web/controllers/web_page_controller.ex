defmodule ReaditLaterWeb.WebPageController do
  use ReaditLaterWeb, :controller

  alias ReaditLater.Pages
  alias ReaditLater.Pages.WebPage

  def index(conn, _params, current_user) do
    web_pages = Pages.list_user_web_pages(current_user)
    render(conn, "index.html", web_pages: web_pages)
  end

  def new(conn, _params, current_user) do
    changeset = Pages.change_web_page(%WebPage{}, current_user)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"web_page" => web_page_params}, current_user) do
    case Pages.create_web_page(current_user, web_page_params) do
      {:ok, web_page} ->
        conn
        |> put_flash(:info, "Web page created successfully.")
        |> redirect(to: Routes.web_page_path(conn, :show, web_page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    web_page = Pages.get_user_web_page!(current_user, id)
    IO.inspect(web_page)
    render(conn, "show.html", web_page: web_page)
  end

  def edit(conn, %{"id" => id}, current_user) do
    web_page = Pages.get_user_web_page!(current_user, id)
    changeset = Pages.change_web_page(web_page)
    render(conn, "edit.html", web_page: web_page, changeset: changeset)
  end

  def update(conn, %{"id" => id, "web_page" => web_page_params}, current_user) do
    web_page = Pages.get_user_web_page!(current_user, id)

    case Pages.update_web_page(web_page, current_user, web_page_params) do
      {:ok, web_page} ->
        conn
        |> put_flash(:info, "Web page updated successfully.")
        |> redirect(to: Routes.web_page_path(conn, :show, web_page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", web_page: web_page, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    web_page = Pages.get_user_web_page!(current_user, id)
    {:ok, _web_page} = Pages.delete_web_page(web_page)

    conn
    |> put_flash(:info, "Web page deleted successfully.")
    |> redirect(to: Routes.web_page_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
