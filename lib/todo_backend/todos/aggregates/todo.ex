defmodule TodoBackend.Todos.Aggregates.Todo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]

  @behaviour Commanded.Aggregates.AggregateLifespan

  alias TodoBackend.Todos.Aggregates.Todo

  alias TodoBackend.Todos.Commands.CreateTodo
  alias TodoBackend.Todos.Commands.DeleteTodo
  alias TodoBackend.Todos.Commands.UpdateTodo

  alias TodoBackend.Todos.Events.TodoCreated
  alias TodoBackend.Todos.Events.TodoDeleted
  alias TodoBackend.Todos.Events.TodoCompleted
  alias TodoBackend.Todos.Events.TodoUncompleted
  alias TodoBackend.Todos.Events.TodoTitleUpdated
  alias TodoBackend.Todos.Events.TodoOrderUpdated

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

  # TODO: validate
  def execute(%Todo{} = todo, %UpdateTodo{} = update) do
    completion_command =
      if todo.completed != update.completed and not is_nil(update.completed) do
        if update.completed do
          %TodoCompleted{uuid: todo.uuid}
        else
          %TodoUncompleted{uuid: todo.uuid}
        end
      end

    title_command =
      if todo.title != update.title and not is_nil(update.title),
        do: %TodoTitleUpdated{uuid: todo.uuid, title: update.title}

    order_command =
      if todo.order != update.order and not is_nil(update.order),
        do: %TodoOrderUpdated{uuid: todo.uuid, order: update.order}

    [completion_command, title_command, order_command] |> Enum.filter(&Function.identity/1)
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

  def apply(%Todo{} = todo, %TodoCompleted{}) do
    %Todo{todo | completed: true}
  end

  def apply(%Todo{} = todo, %TodoUncompleted{}) do
    %Todo{todo | completed: false}
  end

  def apply(%Todo{} = todo, %TodoTitleUpdated{title: title}) do
    %Todo{todo | title: title}
  end

  def apply(%Todo{} = todo, %TodoOrderUpdated{order: order}) do
    %Todo{todo | order: order}
  end

  def apply(%Todo{uuid: uuid}, %TodoDeleted{uuid: uuid}) do
    nil
  end

  def after_command(_command), do: :timer.minutes(1)

  def after_event(%TodoDeleted{}), do: :stop
  def after_event(_event), do: :timer.minutes(1)

  def after_error(_error), do: :timer.minutes(1)
end
