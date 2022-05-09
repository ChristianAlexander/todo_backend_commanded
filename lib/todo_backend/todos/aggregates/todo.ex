defmodule TodoBackend.Todos.Aggregates.Todo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]

  alias TodoBackend.Todos.Aggregates.Todo

  alias TodoBackend.Todos.Commands.CreateTodo
  alias TodoBackend.Todos.Commands.DeleteTodo

  alias TodoBackend.Todos.Events.TodoCreated
  alias TodoBackend.Todos.Events.TodoDeleted

  def execute(%Todo{uuid: nil}, %CreateTodo{} = create) do
    %TodoCreated{
      uuid: create.uuid,
      title: create.title,
      completed: create.completed,
      order: create.order
    }
  end

  def execute(%Todo{uuid: uuid}, %DeleteTodo{uuid: uuid}) do
    %TodoDeleted{uuid: uuid}
  end

  def apply(%Todo{} = todo, %TodoCreated{} = created) do
    %Todo{
      todo
      | uuid: created.uuid,
        title: created.title,
        completed: created.completed,
        order: created.order
    }
  end

  def apply(%Todo{uuid: uuid}, %TodoDeleted{uuid: uuid}) do
    nil
  end
end
