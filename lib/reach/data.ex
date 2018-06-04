defmodule Reach.Team do
  @type t :: %Reach.Team{players: MapSet.t(String.t), name: String.t, score: non_neg_integer, blocked: boolean}

  @enforce_keys [:players, :name, :score, :blocked]
  defstruct [:players, :name, :score, :blocked]

  @doc """
  Instantiates a new Team with default values.
  """
  @spec new(String.t) :: t
  def new(name) do
    %Reach.Team{players: MapSet.new, name: name, score: 0, blocked: false}
  end

  @doc """
  Adds a new player to a team.
  """
  @spec add(t, String.t) :: t
  def add(team, player) do
    update_in(team.players, fn players -> MapSet.put(players, player) end)
  end

  @doc """
  Removes a player from a team.
  """
  @spec remove(t, String.t) :: t
  def remove(team, player) do
    update_in(team.players, fn players -> MapSet.delete(players, player) end)
  end

  @doc """
  Changes the score of the team by delta.
  """
  @spec modify_score(t, integer) :: t
  def modify_score(team, delta) do
    update_in(team.score, fn score -> score + delta end)
  end
end
