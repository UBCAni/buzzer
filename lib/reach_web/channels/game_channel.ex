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
    if socket.assigns.team != nil && socket.assigns.team != nil do
      broadcast!(socket, "disconnected", Reach.Game.remove_member(socket.assigns.team, socket.assigns.name))
    end
  end

  def handle_in("new_team", %{"team" => team}, socket) do
    broadcast!(socket, "new_team", Reach.Game.add_team(team))
    {:noreply, socket}
  end

  def handle_in("player_joined", %{"team" => team, "name" => name}, socket) do
    socket = assign(socket, :name, name) |> assign(:team, team)

    broadcast!(socket, "player_joined", Reach.Game.add_member(team, name))
    {:noreply, socket}
  end

  def handle_in("team_scored", %{"team" => team, "points" => points}, socket) do
    broadcast!(socket, "team_scored", Reach.Game.score_change(team, points))
    {:noreply, socket}
  end

  def handle_in("freeze", %{"team" => team} = body, socket) do
    if Reach.Game.block?(team) do
      broadcast!(socket, "freeze", body)
    end

    {:noreply, socket}
  end

  def handle_in("unfreeze", body, socket) do
    broadcast!(socket, "unfreeze", body)
    {:noreply, socket}
  end

  def handle_in("reset:question", _, socket) do
    broadcast!(socket, "reset:question", Reach.Game.unblock)
    {:noreply, socket}
  end

  def handle_in("reset:game", _, socket) do
    broadcast!(socket, "reset:game", Reach.Game.reset)
    {:noreply, socket}
  end
end
