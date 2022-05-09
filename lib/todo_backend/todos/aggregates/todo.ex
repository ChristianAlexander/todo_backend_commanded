defmodule TodoBackend.Todos.Aggregates.Todo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]

  alias TodoBackend.Todos.Aggregates.Todo

  alias TodoBackend.Todos.Commands.CreateTodo

  alias TodoBackend.Todos.Events.TodoCreated

  def execute(%Todo{uuid: nil}, %CreateTodo{} = create) do
    %TodoCreated{
      uuid: create.uuid,
      title: create.title,
      completed: create.completed,
      order: create.order
    }
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
