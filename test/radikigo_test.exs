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
      {"mi",  [%Pronomo{}],                                                 []},
      {"mi",  [%Pronomo{estas_poseda: :jes}],                               []},
      {"mi",  [%Pronomo{estas_poseda: :jes, kazo: :markita}],               []},
      {"mi",  [%Pronomo{estas_poseda: :jes, nombro: :jes}],                 []},
      {"mi",  [%Pronomo{estas_poseda: :jes, kazo: :markita, nombro: :jes}], []},
      {"ili", [%Pronomo{}],                                                 []},
      {"ili", [%Pronomo{estas_poseda: :jes}],                               []},
      {"ili", [%Pronomo{estas_poseda: :jes, kazo: :markita}],               []},
      {"ili", [%Pronomo{estas_poseda: :jes, nombro: :jes}],                 []},
      {"ili", [%Pronomo{estas_poseda: :jes, kazo: :markita, nombro: :jes}], []}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "unu roots" do

    vortoj    = ["un'", "unuj"]
    anticipoj = zipu(["unu", "unuj"], [:malgrandavorto])
    assert anticipoj == ekruli(vortoj)

  end

  test "poetry" do

    vortoj    = ["poezi'"]
    anticipoj = [{"poezi", [%Ovorto{}], []}]
    assert anticipoj == ekruli(vortoj)

  end

  test "estas in poetry" do

    vortoj = ["'sti"]
    anticipoj = [{"est", [%Verbo{}], []}]
    assert anticipoj == ekruli(vortoj)

  end

  test "nouns" do

    vortoj = ["vorto", "vorton", "vortoj", "vortojn"]
    anticipoj = [
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :sola}],  []},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :sola}],  []},
      {"vort", [%Ovorto{kazo: :malmarkita, nombro: :plura}], []},
      {"vort", [%Ovorto{kazo: :markita,    nombro: :plura}], []}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adjectives" do

    vortoj = ["bona", "bonan", "bonajn", "bonaj"]
    anticipoj = [
      {"bon", [%Avorto{kazo: :malmarkita, nombro: :sola}],  []},
      {"bon", [%Avorto{kazo: :markita,    nombro: :sola}],  []},
      {"bon", [%Avorto{kazo: :markita,    nombro: :plura}], []},
      {"bon", [%Avorto{kazo: :malmarkita, nombro: :plura}], []}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "adverbs" do

    vortoj = ["prompte", "prompten"]
    anticipoj = [
      {"prompt", [%Evorto{kazo: :malmarkita}], []},
      {"prompt", [%Evorto{kazo: :markita}],    []},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "verby verbs" do

    vortoj = ["ami", "amas", "amis", "amos", "amus", "amu"]
    anticipoj = [
      {"am", [%Verbo{formo: :infinitiva}], []},
      {"am", [%Verbo{formo: :nuna}],       []},
      {"am", [%Verbo{formo: :estinta}],    []},
      {"am", [%Verbo{formo: :futuro}],     []},
      {"am", [%Verbo{formo: :kondiĉa}],    []},
      {"am", [%Verbo{formo: :imperativa}], []},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "imperfect verbs" do

    vortoj = [
                "amadi", "amadas", "amadis", "amados", "amadus", "amadu",
                "amado", "amadon", "amadoj", "amadojn"
             ]
    anticipoj = [
      {"am", [%Verbo{formo: :infinitiva, estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :nuna,       estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :estinta,    estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :futuro,     estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :imperativa, estas_perfekto: :ne}],                                             []},
      {"am", [%Verbo{formo: :radikigo,   estas_perfekto: :ne}, %Ovorto{kazo: :malmarkita, nombro: :sola}],  []},
      {"am", [%Verbo{formo: :radikigo,   estas_perfekto: :ne}, %Ovorto{kazo: :markita,    nombro: :sola}],  []},
      {"am", [%Verbo{formo: :radikigo,   estas_perfekto: :ne}, %Ovorto{kazo: :malmarkita, nombro: :plura}], []},
      {"am", [%Verbo{formo: :radikigo,   estas_perfekto: :ne}, %Ovorto{kazo: :markita,    nombro: :plura}], []}
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
      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}], []},

      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}], []},

      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}], []},

      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}], []},

      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}], []},

      {"am", [%Verbo{formo: :infinitiva, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :nuna,       estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :estinta,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :futuro,     estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :kondiĉa,    estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},
      {"am", [%Verbo{formo: :imperativa, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :ekestiĝa}, %Ovorto{}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :finita}, %Ovorto{}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :aktiva, aspecto: :anticipa}, %Ovorto{}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}, %Ovorto{}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}, %Ovorto{}], []},

      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Avorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Evorto{}], []},
      {"am", [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}, %Ovorto{}], []},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "single prefixes" do

    vortoj = [
        "boamo",  "ekamo",  "fiamo",  "geamo",  "reamo",
        "disamo", "eksamo", "eksami", "malamo", "misamo", "praamo"
        ]
    anticipoj = [
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "bo",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "ek",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "fi",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "ge",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "re",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "dis", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "eks", nombro: 1}]},
      {"sam", [%Verbo{}],  [%Affixo{prefikso: "ek",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "mal", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "mis", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Affixo{prefikso: "pra", nombro: 1}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "poly prefixes" do

    vortoj = [
        "bogeamo",  "gebono",  "maleksamo",  "geredispraamo"
        ]
    anticipoj = [
      {"am",  [%Ovorto{}], [
        %Affixo{prefikso: "ge", nombro: 2},
        %Affixo{prefikso: "bo", nombro: 1}
        ]},
      {"bon", [%Ovorto{}], [
        %Affixo{prefikso: "ge", nombro: 1}
        ]},
      {"am",  [%Ovorto{}], [
        %Affixo{prefikso: "eks", nombro: 2},
        %Affixo{prefikso: "mal", nombro: 1}
        ]},
      {"am",  [%Ovorto{}], [
        %Affixo{prefikso: "pra", nombro: 4},
        %Affixo{prefikso: "dis", nombro: 3},
        %Affixo{prefikso: "re",  nombro: 2},
        %Affixo{prefikso: "ge",  nombro: 1}
        ]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "single postfixes" do
    # nouns first
    vortoj1 = [
      "amaĉo", "amaĵo", "amano", "amaro",
      "ameco", "amego", "amejo",
      "amemo", "amero", "ameto", "amido", "amigo",
      "amiĵo", "amilo", "amino", "amono",
      "amopo", "amujo", "amulo", "amumo",
      "ameblo", "amendo", "amfojo", "amindo", "amingo", "amismo", "amisto", "amoblo",
      "amestro"
    ]
    # other stuff including various verb structures
    vortoj2 = [
      # "amaĉe",
      # "amaĉa",
      "amaĉas",
      "amaĉanto"
    ]
    # nicknames
    vortoj3 = [
      "gordonjo",
      "orĉjo"
    ]

    anticipoj1 = [
      {"am", [%Ovorto{}], [%Affixo{postfikso: "aĉ",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "aĵ",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "an",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ar",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ec",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "eg",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ej",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "em",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "er",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "et",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "id",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ig",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "iĵ",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "il",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "in",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "on",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "op",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "uj",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ul",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "um",   nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ebl",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "end",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "foj",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ind",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ing",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ism",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "ist",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "obl",  nombro: 1}]},
      {"am", [%Ovorto{}], [%Affixo{postfikso: "estr", nombro: 1}]}
    ]

    anticipoj2 = [
      #{"am", [%Evorto{}],            [%Affixo{postfikso: "aĉ", nombro: 1}]},
      #{"am", [%Avorto{}],            [%Affixo{postfikso: "aĉ", nombro: 1}]},
      {"am", [%Verbo{formo: :nuna}], [%Affixo{postfikso: "aĉ", nombro: 1}]},
      {"am", [
              %Verbo{formo: :radikigo, estas_partipo: :jes, aspecto: :ekestiĝa},
              %Ovorto{estas_karesnomo: :ne, kazo: :malmarkita, nombro: :sola}
             ],                      [%Affixo{postfikso: "aĉ", nombro: 1}]},
    ]
    anticipoj3 = [
      {"gordonjo", [%Ovorto{estas_karesnomo: :jes}], []},
      {"orĉjo",    [%Ovorto{estas_karesnomo: :jes}], []}
    ]
    assert anticipoj1 ++ anticipoj2 ++ anticipoj3  == ekruli(vortoj1 ++ vortoj2 ++ vortoj3)
  end

  test "false affixes" do
    # words with false affixes
    vortoj = [
      "abono",
      "akrido"
    ]
    anticipoj = [
      {"abon", [%Ovorto{}], []},
      {"akrid",[%Ovorto{}], []}
    ]
    assert anticipoj  == ekruli(vortoj)

  end

  test "words that cannot be Esperanto" do
    vortoj = ["now", "iz", "th", "wintah", "of", "our", "dizkotent"]
    anticipoj = [
      {"now",       [:krokodilo], []},
      {"iz",        [:krokodilo], []},
      {"th",        [:krokodilo], []},
      {"wintah",    [:krokodilo], []},
      {"of",        [:krokodilo], []},
      {"our",       [:krokodilo], []},
      {"dizkotent", [:krokodilo], []}
    ]
    assert anticipoj  == ekruli(vortoj)

  end

#
# Helper functions
#

  defp zipu(list, duplicate) do
    len = length(list)
    zip2 = List.duplicate(duplicate, len)
    zip3 = List.duplicate([], len)
    Enum.zip([list, zip2, zip3])
  end

  defp ekruli(vortoj) do
    _rezultatoj = for v <- vortoj, do: Radikigo.radikigu_vorto_TEST(v)
  end

end
