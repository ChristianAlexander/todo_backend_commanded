defmodule TodoBackend.Todos.Events.TodoUncompleted do
  @derive Jason.Encoder
  defstruct [
    :uuid
  ]
end
