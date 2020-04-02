defmodule RadikigojTest do
  use ExUnit.Case
  doctest Radikigoj

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
      {"mi",  [%Pronomo{}],                                                   []},
      {"mi",  [%Pronomo{estas_poseda: :jes}],                                 []},
      {"mi",  [%Pronomo{estas_poseda: :jes, kazo: :markita}],                 []},
      {"mi",  [%Pronomo{estas_poseda: :jes, nombro: :plura}],                 []},
      {"mi",  [%Pronomo{estas_poseda: :jes, kazo: :markita, nombro: :plura}], []},
      {"ili", [%Pronomo{}],                                                   []},
      {"ili", [%Pronomo{estas_poseda: :jes}],                                 []},
      {"ili", [%Pronomo{estas_poseda: :jes, kazo: :markita}],                 []},
      {"ili", [%Pronomo{estas_poseda: :jes, nombro: :plura}],                 []},
      {"ili", [%Pronomo{estas_poseda: :jes, kazo: :markita, nombro: :plura}], []}
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
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "bo",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "ek",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "fi",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "ge",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "re",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "dis", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "eks", nombro: 1}]},
      {"sam", [%Verbo{}],  [%Afikso{prefikso: "ek",  nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "mal", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "mis", nombro: 1}]},
      {"am",  [%Ovorto{}], [%Afikso{prefikso: "pra", nombro: 1}]}
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "poly prefixes" do

    vortoj = [
        "bogeamo",  "gebono",  "maleksamo",  "geredispraamo"
        ]
    anticipoj = [
      {"am",  [%Ovorto{}], [
        %Afikso{prefikso: "ge", nombro: 2},
        %Afikso{prefikso: "bo", nombro: 1}
        ]},
      {"bon", [%Ovorto{}], [
        %Afikso{prefikso: "ge", nombro: 1}
        ]},
      {"am",  [%Ovorto{}], [
        %Afikso{prefikso: "eks", nombro: 2},
        %Afikso{prefikso: "mal", nombro: 1}
        ]},
      {"am",  [%Ovorto{}], [
        %Afikso{prefikso: "pra", nombro: 4},
        %Afikso{prefikso: "dis", nombro: 3},
        %Afikso{prefikso: "re",  nombro: 2},
        %Afikso{prefikso: "ge",  nombro: 1}
        ]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  # use the fake work root 'nem' because there are no word clashes
  test "single postfixes" do
    # nouns first
    vortoj1 = [
      "nemaĉo", "nemaĵo", "nemano", "nemaro",
      "nemeco", "nemego", "nemejo", "nememo", "nemero", "nemeto",
      "nemido", "nemigo", "nemiĝo", "nemiko", "nemilo", "nemino",
      "nemono", "nemopo", "nemozo",
      "nemujo", "nemulo", "nemumo",
      "nemeblo", "nemendo", "nemesko",
      "nemfojo",
      "nemindo", "nemingo", "nemismo", "nemisto",
      "nemoblo",
      "nemestro",
      "nemologo"
    ]
    # other stuff including various verb structures
    vortoj2 = [
      "nemaĉe",
      "nemaĉa",
      "nemaĉas",
      "nemaĉanto"
    ]
    # nicknames
    vortoj3 = [
      "gordonjo",
      "orĉjo"
    ]

    anticipoj1 = [
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "aĉ",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "aĵ",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "an",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ar",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ec",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "eg",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ej",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "em",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "er",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "et",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "id",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ig",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "iĝ",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ik",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "il",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "in",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "on",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "op",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "oz",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "uj",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ul",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "um",   nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ebl",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "end",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "esk",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "foj",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ind",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ing",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ism",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "ist",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "obl",  nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "estr", nombro: 1}]},
      {"nem", [%Ovorto{}], [%Afikso{postfikso: "olog", nombro: 1}]}
    ]

    anticipoj2 = [
      {"nem", [%Evorto{}],            [%Afikso{postfikso: "aĉ", nombro: 1}]},
      {"nem", [%Avorto{}],            [%Afikso{postfikso: "aĉ", nombro: 1}]},
      {"nem", [%Verbo{formo: :nuna}], [%Afikso{postfikso: "aĉ", nombro: 1}]},
      {"nem", [
              %Verbo{formo: :radikigo, estas_partipo: :jes, aspecto: :ekestiĝa},
              %Ovorto{estas_karesnomo: :ne, kazo: :malmarkita, nombro: :sola}
             ],                      [%Afikso{postfikso: "aĉ", nombro: 1}]},
    ]
    anticipoj3 = [
      {"gordonjo", [%Ovorto{estas_karesnomo: :jes}], []},
      {"orĉjo",    [%Ovorto{estas_karesnomo: :jes}], []}
    ]
    assert anticipoj1 ++ anticipoj2 ++ anticipoj3  == ekruli(vortoj1 ++ vortoj2 ++ vortoj3)
  end

  test "poly postfixes" do

    vortoj = [
      "nemaĉo", "nemaĉaĵo", "nemanaĉaĵo", "nemaranaĉaĵo",
        ]
    anticipoj = [
      {"nem",  [%Ovorto{}], [
        %Afikso{postfikso: "aĉ", nombro: 1}
        ]},
      {"nem", [%Ovorto{}], [
        %Afikso{postfikso: "aĉ", nombro: 2},
        %Afikso{postfikso: "aĵ", nombro: 1}
        ]},
      {"nem",  [%Ovorto{}], [
        %Afikso{postfikso: "an", nombro: 3},
        %Afikso{postfikso: "aĉ", nombro: 2},
        %Afikso{postfikso: "aĵ", nombro: 1}
        ]},
      {"nem",  [%Ovorto{}], [
        %Afikso{postfikso: "ar", nombro: 4},
        %Afikso{postfikso: "an", nombro: 3},
        %Afikso{postfikso: "aĉ",  nombro: 2},
        %Afikso{postfikso: "aĵ",  nombro: 1}
        ]},
    ]
    assert anticipoj == ekruli(vortoj)

  end

  test "poly affixes" do

    vortoj = [
      "genemaĉo", "gebonemaĉaĵo",
        ]
    anticipoj = [
      {"nem",  [%Ovorto{}], [
        %Afikso{postfikso: "aĉ", nombro: 2},
        %Afikso{prefikso:  "ge", nombro: 1}
        ]},
      {"nem", [%Ovorto{}], [
        %Afikso{postfikso: "aĉ", nombro: 4},
        %Afikso{postfikso: "aĵ", nombro: 3},
        %Afikso{prefikso:  "bo", nombro: 2},
        %Afikso{prefikso:  "ge", nombro: 1}
        ]}
    ]
    assert anticipoj == ekruli(vortoj)

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
    _rezultatoj = for v <- vortoj, do: Radikigoj.radikigu_vorto_TEST(v)
  end

end
