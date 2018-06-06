defmodule ReachWeb.GameChannel do
  use Phoenix.Channel

  def join("game:default", _message, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "state", Reach.Game.get())
    {:noreply, socket}
  end

  def terminate(_reason, socket) do
    if Map.has_key?(socket.assigns, :team) && Map.has_key?(socket.assigns, :name)  do
      %{name: name, team: team} = socket.assigns

      Reach.Game.remove_member(team, name)
      broadcast!(socket, "disconnected", %{"team" => team, "name" => name})
    end
  end

  def handle_in("player_joined", %{"team" => team, "name" => name} = body, socket) do
    socket = assign(socket, :name, name) |> assign(:team, team)
    Reach.Game.add_member(team, name)
    broadcast!(socket, "player_joined", body)

    {:noreply, socket}
  end

  def handle_in("team_scored", %{"team" => team, "points" => points}, socket) do
    new_score = Reach.Game.score_change(team, points)[team].score
    broadcast!(socket, "team_scored", %{"team" => team, "points" => new_score})
    {:noreply, socket}
  end

  def handle_in("freeze", %{"team" => team, "name" => name}, socket) do
    # if Reach.Game.block?(team) do
    broadcast!(socket, "freeze", %{"name" => name, "team" => team})
    # end

    {:noreply, socket}
  end

  def handle_in("unfreeze", body, socket) do
    broadcast!(socket, "unfreeze", body)
    {:noreply, socket}
  end

  def handle_in("reset:question", _, socket) do
    Reach.Game.unblock()
    broadcast!(socket, "reset:question", %{})
    {:noreply, socket}
  end

  def handle_in("reset:game", _, socket) do
    Reach.Game.reset()
    broadcast!(socket, "reset:game", %{})
    {:noreply, socket}
  end
end
