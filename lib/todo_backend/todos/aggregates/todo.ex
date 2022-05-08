defmodule TodoBackend.Todos.Aggregates.Todo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order,
    deleted_at: nil
  ]

  @behaviour Commanded.Aggregates.AggregateLifespan

  alias TodoBackend.Todos.Aggregates.Todo

  alias TodoBackend.Todos.Commands.{CreateTodo, DeleteTodo, UpdateTodo, RestoreTodo}

  alias TodoBackend.Todos.Events.{
    TodoCreated,
    TodoDeleted,
    TodoRestored,
    TodoCompleted,
    TodoUncompleted,
    TodoTitleUpdated,
    TodoOrderUpdated
  }

  def execute(%Todo{uuid: nil}, %CreateTodo{} = create) do
    %TodoCreated{
      uuid: create.uuid,
      title: create.title,
      completed: create.completed,
      order: create.order
    }
  end

  def execute(%Todo{uuid: uuid, deleted_at: nil}, %DeleteTodo{uuid: uuid}) do
    %TodoDeleted{uuid: uuid, datetime: DateTime.utc_now()}
  end

  def execute(%Todo{}, %DeleteTodo{}) do
    {:error, "Can not delete todo that is already deleted"}
  end

  def execute(%Todo{deleted_at: nil}, %RestoreTodo{}) do
    {:error, "Can only restore deleted todos"}
  end

  def execute(%Todo{uuid: uuid}, %RestoreTodo{uuid: uuid}) do
    %TodoRestored{uuid: uuid}
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

  def apply(%Todo{uuid: uuid, deleted_at: nil} = todo, %TodoDeleted{
        uuid: uuid,
        datetime: effective_datetime
      }) do
    %Todo{todo | deleted_at: effective_datetime}
  end

  def apply(%Todo{uuid: uuid} = todo, %TodoRestored{uuid: uuid}) do
    %Todo{todo | deleted_at: nil}
  end

  def after_command(_command), do: :timer.minutes(1)

  def after_event(%TodoDeleted{}), do: :stop
  def after_event(_event), do: :timer.minutes(1)

  def after_error(_error), do: :timer.minutes(1)
end
