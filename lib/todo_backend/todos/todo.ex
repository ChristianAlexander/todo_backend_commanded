defmodule TodoBackend.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :completed, :boolean, default: false
    field :title, :string
    field :order, :integer, default: 0

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:title, :completed, :order])
    |> validate_required([:title, :completed])
  end
end
