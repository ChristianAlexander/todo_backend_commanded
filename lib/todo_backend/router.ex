defmodule TodoBackend.Router do
  use Commanded.Commands.Router

  alias TodoBackend.Todos.Aggregates.Todo
  alias TodoBackend.Todos.Commands.CreateTodo

  dispatch([CreateTodo], to: Todo, identity: :uuid)
end
