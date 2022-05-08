defmodule TodoBackend.Todos.Events.TodoRestored do
  @derive Jason.Encoder
  defstruct [
    :uuid
  ]
end
