defmodule TodoBackend.Todos.Events.TodoCreated do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]
end
