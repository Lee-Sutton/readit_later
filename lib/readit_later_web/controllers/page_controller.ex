defmodule ReaditLaterWeb.PageController do
  use ReaditLaterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
