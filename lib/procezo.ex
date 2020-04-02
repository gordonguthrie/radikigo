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
    # we are being naughty and not reversing the paragraph list here
    {_, efikoj} = Enum.reduce(paragrafoj, {1, []}, &estigu_statistikoj/2)
    efikoj
  end

  # make statistics
  defp estigu_statistikoj({paragrafo, vortoj}, {n, efikoj}) do
      fringropremo = :crypto.hash(:sha256, [String.downcase(paragrafo)])
      |> Base.encode16
      |> String.downcase
      neniu_de_vortoj = Enum.reduce(vortoj, 0, &estis_vorto?/2)
      neniu_de_gravuloy = String.length(paragrafo)
      e = %Paragrafo{paragrafo:         paragrafo,
                     identaĵo:          fringropremo,
                     intersekvo:        n,
                     neniu_de_vortoj:   neniu_de_vortoj,
                     neniu_de_gravuloy: neniu_de_gravuloy,
                     radikigoj:         vortoj}
     {n + 1, [e | efikoj]}
  end

  # is this a word
  defp estis_vorto?({:vorto, _}, n), do: n + 1
  defp estis_vorto?(_,           n), do: n


  # process
#  def procezu(teksto, titola, url, uzanto) when is_binary(teksto) do
#    paragrafoj = teksto
#    |> Precipa.analazistu_teksto
#    |> amasigu
#    %Teksto{titola: titola, alŝutota_daktilo: :dh_date.format('Y_m_d:H_i_s'),
#            alŝutano: uzanto, url: url, paragrafoj: paragrafoj}
#  end

#  # collect
#  defp amasigu(efikoj) do
#    afiksa_vortaro = Vorto.akiru_malvera_afikso_vortaro()
#    vortaro = Vorto.akiru_vortaro()
#    Enum.reduce(efikoj, {0, vortaro, afiksa_vortaro, []}, &procezu_efiko/2)
#  end

  # process results
#  defp procezu_efiko({paragrafo, tokenoj}, {vortaro, afiksa_vortaro, efikoj}) do
#    #IO.inspect(intersekvo, label: "intersekvo")
#    {_, _, _, tj} = Enum.reduce(tokenoj, {0, vortaro, afiksa_vortaro, []}, &procezu_vorto/2)
#    e = %Paragrafo{p | radikigoj: tj}
#    #IO.inspect(e, label: "e")
#    {vortaro, afiksa_vortaro, [e | efikoj]}
#  end

#  # process paragraph
#  defp procezu_paragrafo(paragrafo) do
#    identaĵo = :crypto.hash(:sha256, [String.downcase(paragrafo)])
#      |> Base.encode16
#      |> String.downcase

#    %Paragrafo{paragrafo: paragrafo, identaĵo: identaĵo, intersekvo: intersekvo}
#  end

  # process word
  def procezu_vorto({:vorto, {vorto, longaĵo}}, {ekesto, afiksa_vortaro, vortoj}) do
    {radikigo, detaletoj, afiksoj} = Radikigoj.radikigu_vorto(String.downcase(vorto), afiksa_vortaro)
    r = %Radikigo{vorto: vorto, radikigo: radikigo, detaletoj: detaletoj, afiksoj: afiksoj,
                  ekesto: ekesto, longaĵo: longaĵo, estas_vortarero?: :ne}
    {ekesto + longaĵo, afiksa_vortaro, [r | vortoj]}
  end
  def procezu_vorto({_, {_, len}}, {n, afiksa_vortaro, vortoj}) do
    {n + len, afiksa_vortaro, vortoj}
  end

end
