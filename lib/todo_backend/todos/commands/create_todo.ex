defmodule TodoBackend.Todos.Commands.CreateTodo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]
end
