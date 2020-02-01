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
      {"mi",  [%Pronomo{}]},
      {"mi",  [%Pronomo{estis_poseda: :jes}]},
      {"mi",  [%Pronomo{estis_poseda: :jes, kazo: :markita}]},
      {"mi",  [%Pronomo{estis_poseda: :jes, nombro: :jes}]},
      {"mi",  [%Pronomo{estis_poseda: :jes, kazo: :markita, nombro: :jes}]},
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

    vortoj = ["vorto", "vorton", "vortoj", "vortojn"]
    anticipoj = [
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :sola}]},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :sola}]},
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :plura}]},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :plura}]}
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

  test "verby verbs" do

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

  test "imperfect verbs" do

    vortoj = [
                "amadi", "amadas", "amadis", "amados", "amadus", "amadu",
                "amado", "amadon", "amadoj", "amadojn"
             ]
    anticipoj = [
      {"am", [%Verbo{formo: :infinitiva, estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :nuna,       estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :estinta,    estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :futuro,     estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :imperativa, estis_perfekto: :ne}]},
      {"am", [%Verbo{formo: :radikigo,   estis_perfekto: :ne}, %Ovorto{kazo: :malmarkita, nombro: :sola}]},
      {"am", [%Verbo{formo: :radikigo,   estis_perfekto: :ne}, %Ovorto{kazo: :markita,    nombro: :sola}]},
      {"am", [%Verbo{formo: :radikigo,   estis_perfekto: :ne}, %Ovorto{kazo: :malmarkita, nombro: :plura}]},
      {"am", [%Verbo{formo: :radikigo,   estis_perfekto: :ne}, %Ovorto{kazo: :markita,    nombro: :plura}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "aspect verbs" do

    vortoj = [
                "amanti", "amantas", "amantis", "amantos", "amantus", "amantu",
                "amonti", "amontas", "amontis", "amontos", "amontus", "amontu",
                "aminti", "amintas", "amintis", "amintos", "amintus", "amintu",
                "amati",  "amatas",  "amatis",  "amatos",  "amatus",  "amatu",
                "amoti",  "amotas",  "amotis",  "amotos",  "amotus",  "amotu",
                "amiti",  "amitas",  "amitis",  "amitos",  "amitus",  "amitu",
                "amanta", "amante", "amanto",
                "amonta", "amonte", "amonto",
                "aminta", "aminte", "aminto",
                "amata",  "amate",  "amato",
                "amota",  "amote",  "amoto",
                "amita",  "amite",  "amito"
             ]
    anticipoj = [
      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}]},

      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}]},

      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}]},

      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]},

      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]},

      {"am", [%Verbo{formo: :infinitiva, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :nuna,       estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :estinta,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :futuro,     estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :kondiĉa,    estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},
      {"am", [%Verbo{formo: :imperativa, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Ovorto{}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Ovorto{}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Ovorto{}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Ovorto{}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Ovorto{}]},

      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Avorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Evorto{}]},
      {"am", [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Ovorto{}]},

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
