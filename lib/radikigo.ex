defmodule Radikigo do

  use LexLuthor

  @moduledoc """
  Documentation for Radikigo.
  """

  @doc """
  radikigo

  """

  def lexu(teksto) when is_binary(teksto) do
    {:ok, tokenoj} = Lexo.lex(teksto)
    for %LexLuthor.Token{name: n, value: v} <- tokenoj, n != :ws, do: {n, v}
  end

  def dividu_teksto(teksto) when is_binary(teksto) do
    IO.inspect(teksto)
  end

  def radikigu_vorto(vorto) when is_binary(vorto) do
    IO.inspect(vorto)
  end

end
