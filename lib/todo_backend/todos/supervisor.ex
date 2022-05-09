defmodule TodoBackend.Todos.Supervisor do
  use Supervisor

  alias TodoBackend.Todos

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_arg) do
    Supervisor.init(
      [
        Todos.Projectors.Todo
      ],
      strategy: :one_for_one
    )
  end
end
