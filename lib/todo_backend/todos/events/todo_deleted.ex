defmodule TodoBackend.Todos.Events.TodoDeleted do
  @derive Jason.Encoder
  defstruct [
    :uuid
  ]
end
