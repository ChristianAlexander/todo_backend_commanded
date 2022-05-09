defmodule TodoBackend.App do
  use Commanded.Application, otp_app: :todo_backend

  router(TodoBackend.Router)
end
