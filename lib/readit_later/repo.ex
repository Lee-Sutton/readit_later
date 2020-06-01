defmodule ReaditLater.Repo do
  use Ecto.Repo,
    otp_app: :readit_later,
    adapter: Ecto.Adapters.Postgres
end
