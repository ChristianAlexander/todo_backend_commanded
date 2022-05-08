defmodule TodoBackend.Todos.Events.TodoDeleted do
  @derive Jason.Encoder
  defstruct [
    :uuid,
    :datetime
  ]

  alias TodoBackend.Todos.Events.TodoDeleted

  defimpl Commanded.Serialization.JsonDecoder, for: TodoDeleted do
    @doc """
    Parse the datetime included in the aggregate state
    """
    def decode(%TodoDeleted{} = state) do
      %TodoDeleted{datetime: datetime} = state

      if datetime == nil do
        %TodoDeleted{state | datetime: DateTime.utc_now()}
      else
        {:ok, dt, _} = DateTime.from_iso8601(datetime)

        %TodoDeleted{state | datetime: dt}
      end
    end
  end
end
