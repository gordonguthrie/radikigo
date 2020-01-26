defmodule Radikigo do

  use LexLuthor

  @moduledoc """
  Documentation for Radikigo.
  """

  @doc """
  radikigo

  """

  def analazistu_teksto(teksto) when is_binary(teksto) do
    tokenoj = lexu(teksto)
    frazoj = amasigu_frazo(tokenoj)
  end

  def lexu(teksto) when is_binary(teksto) do
    {:ok, tokenoj} = Lexo.lex(teksto)
    tokenoj
    |> amasigu_tokenoj
  end

  def dividu_teksto(teksto) when is_binary(teksto) do
    IO.inspect(teksto)
  end

  def radikigu_vorto(vorto) when is_binary(vorto) do
    IO.inspect(vorto)
  end

  defp amasigu_tokenoj(tokenoj) do
    for %LexLuthor.Token{name: n, value: v} <- tokenoj, n != :ws, do: {n, v}
  end

  defp amasigu_frazo(tokenoj) do
    amasigu_frazo2(tokenoj, false, [], [])
  end

  defp amasigu_frazo2([], _is_in_quotes, [], frazoj), do: Enum.reverse(frazoj)
  defp amasigu_frazo2([], _is_in_quotes, frazo, frazoj), do: Enum.reverse([Enum.reverse(frazo) | frazoj])
  defp amasigu_frazo2([{:quotes, q} | tail], false, frazo, frazoj) do
    amasigu_frazo2(tail, true, [{:quotes, q} | frazo], frazoj)
  end
  defp amasigu_frazo2([{:quotes, q} | tail], true, frazo, frazoj) do
    amasigu_frazo2(tail, false, [{:quotes, q} | frazo], frazoj)
  end
  defp amasigu_frazo2([{:punkto, p} | tail], false, frazo, frazoj) do
    neufrazo = Enum.reverse([{:punkto, p} | frazo])
    amasigu_frazo2(tail, false, [], [neufrazo | frazoj])
  end
  defp amasigu_frazo2([head | tail], is_in_quotes, frazo, frazoj) do
    amasigu_frazo2(tail, is_in_quotes, [head | frazo], frazoj)
  end

end
