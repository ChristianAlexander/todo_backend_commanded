defmodule TodoBackend.Router do
  use Commanded.Commands.Router

  alias TodoBackend.Todos.Aggregates.Todo
  alias TodoBackend.Todos.Commands.CreateTodo
  alias TodoBackend.Todos.Commands.DeleteTodo
  alias TodoBackend.Todos.Commands.UpdateTodo

  dispatch([CreateTodo, DeleteTodo, UpdateTodo], to: Todo, identity: :uuid, lifespan: Todo)
end
