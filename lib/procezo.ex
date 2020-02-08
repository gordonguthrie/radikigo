defmodule Procezo do

  def procezu(teksto) when is_binary(teksto) do
    efiko = teksto
    |> Precipa.analazistu_teksto
    |> amasigu

    efiko
  end

  defp amasigu(efikoj) do
    vortaro = Vorto.akiru_malvera_affikso_vortaro()
    for {paragrafo, tokenoj} <- efikoj do
      Enum.reduce(tokenoj, {0, [], vortaro}, &procezu_vorto/2)
    end
  end

  defp procezu_vorto({:vorto, {vorto, len}}, {n, vortoj, vortaro}) do
    IO.inspect(vorto, label: "word")
    IO.inspect(n)
    radikigo = Radikigo.radikigu_vorto(String.downcase(vorto), vortaro)
    IO.inspect(radikigo, label: "radical")
    {n + len, [{radikigo, n, len} | vortoj], vortaro}
  end
  defp procezu_vorto({_, {_, len}}, {n, vortoj, vortaro}) do
    {n + len, vortoj, vortaro}
  end

end
