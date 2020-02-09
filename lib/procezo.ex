defmodule Procezo do

  def procezu(teksto, titola, url, uzanto) when is_binary(teksto) do
    paragrafoj = teksto
    |> Precipa.analazistu_teksto
    |> amasigu
    %Teksto{titola: titola, alŝutota_daktilo: :dh_date.format('Y_m_d:H_i_s'),
            alŝutano: uzanto, url: url, paragrafoj: paragrafoj}
  end

  defp amasigu(efikoj) do
    afiksa_vortaro = Vorto.akiru_malvera_afikso_vortaro()
    vortaro = Vorto.akiru_vortaro()
    IO.inspect(length(efikoj), label: "number of paragraphs")
    Enum.reduce(efikoj, {0, vortaro, afiksa_vortaro, []}, &procezu_efiko/2)
  end

  defp procezu_efiko({paragrafo, tokenoj}, {intersekvo, vortaro, afiksa_vortaro, efikoj}) do
    p = procezu_paragrafo(paragrafo, intersekvo)
    IO.inspect(intersekvo, label: "intersekvo")
    {_, _, _, tj} = Enum.reduce(tokenoj, {0, vortaro, afiksa_vortaro, []}, &procezu_vorto/2)
    e = %Paragrafo{p | radikigoj: tj, intersekvo: intersekvo}
    IO.inspect(e, label: "e")
    {intersekvo + 1, vortaro, afiksa_vortaro, [e | efikoj]}
  end

  defp procezu_paragrafo(paragrafo, intersekvo) do
    paragrafo2 = String.downcase(paragrafo)
    %Paragrafo{paragrafo: paragrafo, identaĵo: :crypto.hash(:sha256,paragrafo2), intersekvo: intersekvo}
  end

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
