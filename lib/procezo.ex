defmodule Procezo do

  def procezu(teksto) when is_binary(teksto) do
    teksto
    |> Precipa.analazistu_teksto
    |> amasigu

  end

  defp amasigu(efikoj) do
    for {paragrafo, tokenoj} <- efikoj do
      IO.inspect(paragrafo, label: "paragraph")
      Enum.reduce(tokenoj, 0, &procezu_vortoj/2)
    end
  end

  defp procezu_vortoj({:vorto, {vorto, len}}, n) do
    IO.inspect(vorto, label: "word")
    IO.inspect(n)
    n + len
  end
  defp procezu_vorto(x, n) do
    IO.inspect(x, label: "x")
  end

end
