defmodule TodoBackend.Todos.Commands.UpdateTodo do
  defstruct [
    :uuid,
    :title,
    :completed,
    :order
  ]

  use ExConstructor

  alias TodoBackend.Todos.Commands.UpdateTodo

  def assign_uuid(%UpdateTodo{} = update_todo, uuid) do
    %UpdateTodo{update_todo | uuid: uuid}
  end
end
