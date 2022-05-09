defmodule TodoBackend.Todos.Events.TodoTitleUpdated do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :title
  ]
end
