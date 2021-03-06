defmodule TodoBackendWeb.TodoController do
  use TodoBackendWeb, :controller

  alias TodoBackend.Todos
  alias TodoBackend.Todos.Projections.Todo

  action_fallback TodoBackendWeb.FallbackController

  def index(conn, _params) do
    todos = Todos.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, todo_params) do
    with {:ok, %Todo{} = todo} <- Todos.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.todo_path(conn, :show, todo))
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def restore(conn, %{"id" => id}) do
    with {:ok, %Todo{} = todo} <- Todos.restore_todo(id) do
      render(conn, "show.json", todo: todo)
    end
  end

  def update(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)

    update_values = conn.body_params

    with {:ok, %Todo{} = todo} <- Todos.update_todo(todo, update_values) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)

    with :ok <- Todos.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete_all(conn, _params) do
    Todos.delete_all_todos()

    send_resp(conn, :no_content, "")
  end
end
