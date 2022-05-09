defmodule TodoBackend.Todos.Commands.CreateTodo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]

  use ExConstructor

  alias TodoBackend.Todos.Commands.CreateTodo

  def assign_uuid(%CreateTodo{} = create_todo, uuid) do
    %CreateTodo{create_todo | uuid: uuid}
  end
end
