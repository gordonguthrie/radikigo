defmodule RadikigoTest do
  use ExUnit.Case
  doctest Radikigo

  test "standalone roots" do

    vortoj    = ["ĉar", "ĉi", "ĉu"]
    anticipoj = zip(vortoj, :malgrandavorto)

    rezultatoj = for v <- vortoj, do: Radikigo.radikigu_vorto(v)

    assert anticipoj == rezultatoj

  end

  test "prepositions roots" do

    vortoj    = ["la", "l'"]
    anticipoj = zip(["la", "la"], :malgrandavorto)

    rezultatoj = for v <- vortoj, do: Radikigo.radikigu_vorto(v)

    assert anticipoj == rezultatoj

  end

defp zip(list, duplicate) do
  len = length(list)
  zip2 = List.duplicate(duplicate, len)
  Enum.zip(list, zip2)
end


end
