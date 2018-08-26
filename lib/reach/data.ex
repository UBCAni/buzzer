defmodule Reach.Team do
  @type t :: %Reach.Team{players: MapSet.t(String.t), name: String.t, score: non_neg_integer, buzzed: boolean}

  @enforce_keys [:players, :name, :score, :buzzed]
  defstruct [:players, :name, :score, :buzzed]

  @doc """
  Instantiates a new Team with default values.
  """
  @spec new(String.t) :: t
  def new(name) do
    %Reach.Team{players: MapSet.new, name: name, score: 0, buzzed: false}
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
