defmodule TodoBackend.Todos.Commands.UpdateTodo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]
end
