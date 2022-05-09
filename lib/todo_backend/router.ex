defmodule TodoBackend.Router do
  use Commanded.Commands.Router

  alias TodoBackend.Todos.Aggregates.Todo
  alias TodoBackend.Todos.Commands.CreateTodo
  alias TodoBackend.Todos.Commands.DeleteTodo

  dispatch([CreateTodo], to: Todo, identity: :uuid)
  dispatch([DeleteTodo], to: Todo, identity: :uuid)
end
