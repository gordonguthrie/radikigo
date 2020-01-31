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

  test "correlatives" do

    vortoj1 = [
      	"kia",   "kial",   "kiam",   "kie",   "kiel",   "kies",   "kio",   "kiom",   "kiu",
      	"tia",   "tial",   "tiam",   "tie",   "tiel",   "ties",   "tio",   "tiom",   "tiu",
      	"ia",    "ial",    "iam",    "ie",    "iel",    "ies",    "io",    "iom",    "iu",
      	"ĉia",   "ĉial",   "ĉiam",   "ĉie",   "ĉiel",   "ĉies",   "ĉio",   "ĉiom",   "ĉiu",
      	"nenia", "nenial", "neniam", "nenie", "neniel", "nenies", "nenio", "neniom", "neniu"
      ]
      vortoj2 = [
        	"kien",
        	"tien",
        	"ien",
        	"ĉien",
        	"nenien"
        ]

      anticipoj1 = zipu(vortoj1, [%Korelatevo{}])
      anticipoj2 = zipu(vortoj2, [%Korelatevo{kazo: :markita}])

      assert anticipoj1 ++ anticipoj2 == ekruli(vortoj1 ++ vortoj2)

  end

  test "pronouns" do

    vortoj =  [
      "mi",
      "mia",
      "mian",
      "miaj",
      "miajn",
      "ili",
      "ilia",
      "ilian",
      "iliaj",
      "iliajn",
    ]
    anticipoj = [
      {"mi", [%Pronomo{}]},
      {"mi", [%Pronomo{estis_poseda: :jes}]},
      {"mi", [%Pronomo{estis_poseda: :jes, kazo: :markita}]},
      {"mi", [%Pronomo{estis_poseda: :jes, nombro: :jes}]},
      {"mi", [%Pronomo{estis_poseda: :jes, kazo: :markita, nombro: :jes}]},
      {"ili", [%Pronomo{}]},
      {"ili", [%Pronomo{estis_poseda: :jes}]},
      {"ili", [%Pronomo{estis_poseda: :jes, kazo: :markita}]},
      {"ili", [%Pronomo{estis_poseda: :jes, nombro: :jes}]},
      {"ili", [%Pronomo{estis_poseda: :jes, kazo: :markita, nombro: :jes}]}
    ]
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
    anticipoj = [{"est", [%Verbo{}]}]
    assert anticipoj == ekruli(vortoj)

  end

  test "nouns" do

    vortoj = ["vorto", "vorton", "vortojn", "vortoj"]
    anticipoj = [
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :sola}]},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :sola}]},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :plura}]},
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :plura}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adjectives" do

    vortoj = ["bona", "bonan", "bonajn", "bonaj"]
    anticipoj = [
      {"bon", [%Avorto{kazo: :malmarkita, nombro: :sola}]},
      {"bon", [%Avorto{kazo: :markita,    nombro: :sola}]},
      {"bon", [%Avorto{kazo: :markita,    nombro: :plura}]},
      {"bon", [%Avorto{kazo: :malmarkita, nombro: :plura}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adverbs" do

    vortoj = ["prompte", "prompten"]
    anticipoj = [
      {"prompt", [%Evorto{kazo: :malmarkita}]},
      {"prompt", [%Evorto{kazo: :markita}]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test " verby verbs" do

    vortoj = ["ami", "amas", "amis", "amos", "amus", "amu"]
    anticipoj = [
      {"am", [%Verbo{formo: :infinitiva}]},
      {"am", [%Verbo{formo: :nuna}]},
      {"am", [%Verbo{formo: :estinta}]},
      {"am", [%Verbo{formo: :futuro}]},
      {"am", [%Verbo{formo: :kondiĉa}]},
      {"am", [%Verbo{formo: :imperativa}]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

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
