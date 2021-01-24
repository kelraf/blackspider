defmodule BlackspiderWeb.PageController do
  use BlackspiderWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
