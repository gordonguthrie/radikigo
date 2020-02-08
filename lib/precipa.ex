defmodule Precipa do

  use LexLuthor

  @moduledoc """
  Documentation for Radikigo.
  """

  @doc """
  radikigo

  """

  # analyse text
  def analazistu_teksto(teksto) when is_binary(teksto) do

  paragrafoj = String.split(teksto, "\n\n")

   tokenoj = for p <- paragrafoj, p != "" and p != "\"" do
      p
      |> punktu
      |> lexu
    end

    tokenoj2 = List.flatten(tokenoj)

    tokenoj2
    |> amasigu_frazo
    |> faru_signovico
  end

  # divide text
  def dividu_teksto(teksto) when is_binary(teksto) do
    teksto
    |> preparu_alfabeto
    |> analazistu_teksto
  end

  # prepare the alphabet
  def preparu_alfabeto(teksto) when is_binary(teksto) do
    teksto
    |> anstatŭi("cx", "ĉ")
    |> anstatŭi("cX", "ĉ")
    |> anstatŭi("Cx", "Ĉ")
    |> anstatŭi("CX", "Ĉ")
    |> anstatŭi("gx", "ĝ")
    |> anstatŭi("gX", "ĝ")
    |> anstatŭi("Gx", "Ĝ")
    |> anstatŭi("GX", "Ĝ")
    |> anstatŭi("hx", "ĥ")
    |> anstatŭi("hX", "ĥ")
    |> anstatŭi("Hx", "Ĥ")
    |> anstatŭi("HX", "Ĥ")
    |> anstatŭi("jx", "ĵ")
    |> anstatŭi("jX", "ĵ")
    |> anstatŭi("Jx", "Ĵ")
    |> anstatŭi("JX", "Ĵ")
    |> anstatŭi("sx", "ŝ")
    |> anstatŭi("sX", "ŝ")
    |> anstatŭi("Sx", "Ŝ")
    |> anstatŭi("SX", "Ŝ")
    |> anstatŭi("ux", "ŭ")
    |> anstatŭi("uX", "ŭ")
    |> anstatŭi("Ux", "Ŭ")
    |> anstatŭi("UX", "Ŭ")
    |> anstatŭi("ch", "ĉ")
    |> anstatŭi("cH", "ĉ")
    |> anstatŭi("Ch", "Ĉ")
    |> anstatŭi("CH", "Ĉ")
    |> anstatŭi("gh", "ĝ")
    |> anstatŭi("gH", "ĝ")
    |> anstatŭi("Gh", "Ĝ")
    |> anstatŭi("GH", "Ĝ")
    |> anstatŭi("hh", "ĥ")
    |> anstatŭi("hH", "ĥ")
    |> anstatŭi("Hh", "Ĥ")
    |> anstatŭi("HH", "Ĥ")
    |> anstatŭi("jh", "ĵ")
    |> anstatŭi("jH", "ĵ")
    |> anstatŭi("Jh", "Ĵ")
    |> anstatŭi("JH", "Ĵ")
    |> anstatŭi("sh", "ŝ")
    |> anstatŭi("sH", "ŝ")
    |> anstatŭi("Sh", "Ŝ")
    |> anstatŭi("SH", "Ŝ")
    |> anstatŭi("uh", "ŭ")
    |> anstatŭi("uH", "ŭ")
    |> anstatŭi("Uh", "Ŭ")
    |> anstatŭi("UH", "Ŭ")
  end

  # lex
  def lexu(teksto) when is_binary(teksto) do
    {:ok, tokenoj} = Lexo.lex(teksto)
    tokenoj
    |> amasigu_tokenoj
  end

  # collect tokens
  def amasigu_tokenoj(tokenoj) do
    for %LexLuthor.Token{name: n, value: v} <- tokenoj, do: {n, v}
  end

  # filter whitespace
  def filtru_interspaco(tokenoj) do
    for {n, v} <- tokenoj, n != :ws, do: {n, v}
  end

  defp punktu(paragrafo) do
    IO.inspect(paragrafo)
    len = String.length(paragrafo)
    case String.slice(paragrafo, len-1..len) do
      "." -> paragrafo
      _   -> paragrafo <> "."
    end
  end

  # make string
  defp faru_signovico(frazo) do
    for f <- frazo do
      paragrafo = String.trim(Enum.reduce(Enum.reverse(f), "", fn({_n, {v, _l}}, acc) -> v <> acc end))
      {paragrafo, f}
   end
  end

  # collect sentences (the parser)
  defp amasigu_frazo(tokenoj) do
    amasigu_frazo2(tokenoj, [], [])
  end

  defp amasigu_frazo2([], [], frazoj), do: Enum.reverse(frazoj)
  defp amasigu_frazo2([], frazo, frazoj), do: Enum.reverse([Enum.reverse(frazo) | frazoj])
  defp amasigu_frazo2([{:crlf, ""} | tail], frazo, frazoj) do
    neufrazo = Enum.reverse(frazo)
    amasigu_frazo2(tail, [], [neufrazo | frazoj])
  end
  defp amasigu_frazo2([{:punkto, p} | tail], frazo, frazoj) do
    neufrazo = Enum.reverse([{:punkto, p} | frazo])
    amasigu_frazo2(tail, [], [neufrazo | frazoj])
  end
  defp amasigu_frazo2([head | tail], frazo, frazoj) do
    amasigu_frazo2(tail, [head | frazo], frazoj)
  end

  # replace
  defp anstatŭi(teksto, maljuna, juna) do
    String.replace(teksto, maljuna, juna, [global: true])
  end

end
