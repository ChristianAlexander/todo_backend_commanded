defmodule TodoBackend.Repo do
  use Ecto.Repo,
    otp_app: :todo_backend,
    adapter: Ecto.Adapters.Postgres
end
