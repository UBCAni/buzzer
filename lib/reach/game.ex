defmodule Reach.Game do
  @type t :: %{optional(String.t) => %Reach.Team{}}

  def start_link() do
    Agent.start_link(fn ->
      Map.new
        |> Map.put("shiani", Reach.Team.new("shiani"))
        |> Map.put("tano", Reach.Team.new("tano"))
    end, name: __MODULE__)
  end

  @doc """
  Gets the current game state.
  """
  @spec get() :: t
  def get() do
    Agent.get(__MODULE__, &(&1))
  end

  @doc """
  Add a new team to the game.
  """
  @spec add_team(String.t) :: t
  def add_team(name) do
    Agent.get_and_update(__MODULE__, fn state ->
      result = Map.put(state, name, Reach.Team.new(name))

      {result, result}
    end)
  end

  @doc """
  Add a new member to a team.
  """
  @spec add_member(String.t, String.t) :: t | none
  def add_member(team, name) do
    Agent.get_and_update(__MODULE__, fn state ->
      case state[team] do
        nil -> {state, state}
        _ ->
          result = update_in(state[team], &Reach.Team.add(&1, name))
          {result, result}
      end
    end)
  end

  @doc """
  Removes a player from a team.
  """
  @spec remove_member(String.t, String.t) :: t | none
  def remove_member(team, name) do
    Agent.get_and_update(__MODULE__, fn state ->
      case state[team] do
        nil -> {state, state}
        _ ->
          result = update_in(state[team], &Reach.Team.remove(&1, name))
          {result, result}
      end
    end)
  end

  @doc """
  Adjust the score of the team.
  """
  @spec score_change(String.t, integer) :: t
  def score_change(team, value) do
    Agent.get_and_update(__MODULE__, fn state ->
      case state[team] do
        nil -> {state, state}
        _ ->
            result = update_in(state[team], &Reach.Team.modify_score(&1, value))
            {result, result}
      end
    end)
  end

  @doc """
  Resets the game state to the start of a new game.
  """
  @spec reset() :: t
  def reset() do
    Agent.get_and_update(__MODULE__, fn state ->
      result = Enum.map(state, fn {k, v} -> {k, %{v | :score => 0, :blocked => false}} end) |> Enum.into(%{})
      {result, result}
    end)
  end

  @doc """
  Allows all teams to buzz again.
  """
  @spec unblock() :: t
  def unblock() do
    Agent.get_and_update(__MODULE__, fn state ->
      result = Enum.map(state, fn {k, v} -> {k, %{v | :blocked => false}} end) |> Enum.into(%{})
      {result, result}
    end)
  end

  @doc """
  Checks to see if the team can block.
  """
  @spec block?(String.t) :: boolean
  def block?(team) do
    if team == nil do
      true
    else
      Agent.get_and_update(__MODULE__, fn state ->
        case state[team] do
          nil -> {false, state}
          _ ->
              if state[team].blocked do
                {false, state}
              else
                {true, update_in(state[team].blocked, &(!/1))}
              end
          end
        end)
      end
  end
end
