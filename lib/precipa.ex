defmodule Precipa do

  use LexLuthor

  @moduledoc """
  Documentation for the `Radikigo` module `Precipa`.

  This is the main module and provides
  the API interface for the system that uses Radikigo

  It uses the LexLuthor package for lexing
  """

  @doc """
  `Precipa.dividu_teksto` breaks the text up into parapgraphs.

  It normalises the text by:

  * transforming the writing to standard Experanto (eg cx to ĉ etc)
  * lexing the string into tokens (words, puncturation)
  * normalising white space (one space beween words, trim at start and end)
  * normalising quotation (German and French style quotation marks are rendered English style)

  """
  def dividu_teksto(teksto) when is_binary(teksto) do
    teksto
    |> preparu_alfabeto
    |> analazistu_teksto
  end

  @doc """
  `Precipa.analazistu_teksto` analyzes text
  
  It makes a first cut at paragraphs (based on double line ends)
  and then fixes up some punctuation and trimming issues and then
  calls the lexer which turns the paragraphs into strings of tokens
  """
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

  @doc """
  `Precipa.preparu_alfabeto` prepares the alphabet
  ie switch to proper esperanto from
  escaped characters
  """
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

  @doc """
  `Precipa.lexu` lexes the text in a paragraph into tokens
  and then collects them up
  """
  def lexu(teksto) when is_binary(teksto) do
    {:ok, tokenoj} = Lexo.lex(teksto)
    tokenoj
    |> amasigu_tokenoj
  end

  @doc """
  `Precipa.amasigu_tokenoj` collects up the tokens
  """
  def amasigu_tokenoj(tokenoj) do
    for %LexLuthor.Token{name: n, value: v} <- tokenoj, do: {n, v}
  end

  @doc """
  `Precipa.filtru_interspaco` filters whitespace out
  """
  def filtru_interspaco(tokenoj) do
    for {n, v} <- tokenoj, n != :ws, do: {n, v}
  end

  # Precipa.punktu tidies up punctuation
  defp punktu(paragrafo) do
    len = String.length(paragrafo)
    case String.slice(paragrafo, len-1..len) do
      "." -> String.trim(paragrafo)
      _   -> String.trim(paragrafo) <> "."
    end
  end

  # Precipa.faru_signovico makes strings from phrases which
  # are lists of tokens
  defp faru_signovico(frazo) do
    for f <- frazo do
      paragrafo = String.trim(Enum.reduce(Enum.reverse(f), "", fn({_n, {v, _l}}, acc) -> v <> acc end))
      {paragrafo, f}
   end
  end

  # Precipa.amasigu_frazo collects sentences from phrases.
  # It is the parser - it tries to respect quotation marks
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
