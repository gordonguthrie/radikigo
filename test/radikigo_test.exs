defmodule RadikigoTest do
  use ExUnit.Case
  doctest Radikigo

  test "standalone roots" do

    vortoj    = ["ĉar", "ĉi", "ĉu"]
    anticipoj = zipu(vortoj, [:malgrandavorto])
    assert anticipoj == ekruli(vortoj)

  end

  test "prepositions roots" do

    vortoj    = ["la", "l'"]
    anticipoj = zipu(["la", "la"], [:malgrandavorto])
    assert anticipoj == ekruli(vortoj)

  end

  test "unu roots" do

    vortoj    = ["un'", "unuj"]
    anticipoj = zipu(["unu", "unuj"], [:malgrandavorto])
    assert anticipoj == ekruli(vortoj)

  end

  test "poetry" do

    vortoj    = ["poeziĵ'"]
    anticipoj = [{"poeziĵo", [%Ovorto{}]}]
    assert anticipoj == ekruli(vortoj)

  end

  test "estis in poetry" do

    vortoj = ["'sti"]
    anticipoj = [{"esti", [%Verbo{}]}]
    assert anticipoj == ekruli(vortoj)

  end

  test "nouns" do

    vortoj = ["vorto", "vorton", "vortojn", "vortoj"]
    anticipoj = [
      {"vorto", [%Ovorto{kazo: :malmarkita, nombro: :sola}]},
      {"vorto", [%Ovorto{kazo: :markita,    nombro: :sola}]},
      {"vorto", [%Ovorto{kazo: :markita,    nombro: :plura}]},
      {"vorto", [%Ovorto{kazo: :malmarkita, nombro: :plura}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adjectives" do

    vortoj = ["bona", "bonan", "bonajn", "bonaj"]
    anticipoj = [
      {"bona", [%Avorto{kazo: :malmarkita, nombro: :sola}]},
      {"bona", [%Avorto{kazo: :markita,    nombro: :sola}]},
      {"bona", [%Avorto{kazo: :markita,    nombro: :plura}]},
      {"bona", [%Avorto{kazo: :malmarkita, nombro: :plura}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adverbs" do

    vortoj = ["prompte", "prompten"]
    anticipoj = [
      {"prompte", [%Evorto{kazo: :malmarkita}]},
      {"prompte", [%Evorto{kazo: :markita}]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

#  test "verbs" do

#  end


#
# Helper functions
#

  defp zipu(list, duplicate) do
    len = length(list)
    zip2 = List.duplicate(duplicate, len)
    Enum.zip(list, zip2)
  end

  defp ekruli(vortoj) do
    _rezultatoj = for v <- vortoj, do: Radikigo.radikigu_vorto(v)
  end

end
