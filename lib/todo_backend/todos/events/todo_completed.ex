defmodule TodoBackend.Todos.Events.TodoCompleted do
  @derive Jason.Encoder
  defstruct [
    :uuid
  ]
end
