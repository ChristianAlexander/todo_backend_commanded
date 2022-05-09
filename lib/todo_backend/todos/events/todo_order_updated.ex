defmodule TodoBackend.Todos.Events.TodoOrderUpdated do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :order
  ]
end
