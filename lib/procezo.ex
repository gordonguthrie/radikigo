defmodule Procezo do

  @moduledoc """
  Documentation for the Radikigo module Procezo.

  This is the main module and provides
  the API interface for the system that uses Radikigo
  """

  @doc """
  `Procezo.estigu_paragrafoj` takes a text and breaks it into parapgraps with
   
   * a signature formed by hashing a canonicalised text
   * a word list for parsing
   * basic statistics
      * no of characters
      * no of words
  """ 

  def estigu_paragrafoj(teksto) when is_binary(teksto) do
    paragrafoj = teksto
    |> Precipa.analazistu_teksto

    neniu_de_paragrafoj = length(paragrafoj)
    IO.inspect(neniu_de_paragrafoj, label: "no of paragraphs")
    Enum.map(paragrafoj, &estigu_statistikoj/1)
  end


  # process
  def procezu(teksto, titola, url, uzanto) when is_binary(teksto) do
    paragrafoj = teksto
    |> Precipa.analazistu_teksto
    |> amasigu
    %Teksto{titola: titola, alŝutota_daktilo: :dh_date.format('Y_m_d:H_i_s'),
            alŝutano: uzanto, url: url, paragrafoj: paragrafoj}
  end

  # make statistics
  defp estigu_statistikoj({paragrafo, vortoj}) do
      fringropremo = :crypto.hash(:sha256, [String.downcase(paragrafo)])
      |> Base.encode16
      |> String.downcase
      IO.inspect(fringropremo, label: "fingerprint")
      IO.inspect(paragrafo, label: "para")
      #IO.inspect(vortoj, label: "words")
      neniu_de_vortoj = Enum.reduce(vortoj, 0, &estis_vorto?/2)
      IO.inspect(neniu_de_vortoj, label: "no of words")
      neniu_de_gravuloy = String.length(paragrafo)
      IO.inspect(neniu_de_gravuloy, label: "no of chars")
      {paragrafo, vortoj}
  end

  # is this a word
  defp estis_vorto?({:vorto, _}, n), do: n + 1
  defp estis_vorto?(_,           n), do: n

  # collect
  defp amasigu(efikoj) do
    afiksa_vortaro = Vorto.akiru_malvera_afikso_vortaro()
    vortaro = Vorto.akiru_vortaro()
    Enum.reduce(efikoj, {0, vortaro, afiksa_vortaro, []}, &procezu_efiko/2)
  end

  # process results
  defp procezu_efiko({paragrafo, tokenoj}, {intersekvo, vortaro, afiksa_vortaro, efikoj}) do
    p = procezu_paragrafo(paragrafo, intersekvo)
    #IO.inspect(intersekvo, label: "intersekvo")
    {_, _, _, tj} = Enum.reduce(tokenoj, {0, vortaro, afiksa_vortaro, []}, &procezu_vorto/2)
    e = %Paragrafo{p | radikigoj: tj, intersekvo: intersekvo}
    #IO.inspect(e, label: "e")
    {intersekvo + 1, vortaro, afiksa_vortaro, [e | efikoj]}
  end

  # process paragraph
  defp procezu_paragrafo(paragrafo, intersekvo) do
    identaĵo = :crypto.hash(:sha256, [String.downcase(paragrafo)])
      |> Base.encode16
      |> String.downcase

    %Paragrafo{paragrafo: paragrafo, identaĵo: identaĵo, intersekvo: intersekvo}
  end

  # process word
  defp procezu_vorto({:vorto, {vorto, longaĵo}}, {ekesto, vortaro, afiksa_vortaro, vortoj}) do
    {radikigo, detaletoj, afiksoj} = Radikigoj.radikigu_vorto(String.downcase(vorto), afiksa_vortaro)
    estas_vortarero? = case :dict.is_key(radikigo, vortaro) do
      true  -> :jes
      false -> :ne
    end
    r = %Radikigo{vorto: vorto, radikigo: radikigo, detaletoj: detaletoj, afiksoj: afiksoj,
                  ekesto: ekesto, longaĵo: longaĵo, estas_vortarero?: estas_vortarero?}
    {ekesto + longaĵo, vortaro, afiksa_vortaro, [r | vortoj]}
  end
  defp procezu_vorto({_, {_, len}}, {n, vortaro, afiksa_vortaro, vortoj}) do
    {n + len, vortaro, afiksa_vortaro, vortoj}
  end

end
