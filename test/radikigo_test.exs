defmodule RadikigoTest do
  use ExUnit.Case
  doctest Radikigo

  test "lex simple words" do

    teksto = "laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ"

    lexigoj = [
      vorto:  "laŭ",
      vorto:  "Ludoviko",
      vorto:  "Zamenhof",
      vorto:  "bongustas",
      vorto:  "freŝa",
      vorto:  "ĉeĥa",
      vorto:  "manĝaĵo",
      vorto:  "kun",
      vorto:  "spicoj",
      punkto: ".",
      vorto:  "LAŬ",
      vorto:  "LUDOVIKO",
      vorto:  "ZAMENHOF",
      vorto:  "BONGUSTAS",
      vorto:  "FREŜA",
      vorto:  "ĈEĤA",
      vorto:  "MANĜAĴO",
      vorto:  "KUN",
      vorto:  "SPICOJ"
    ]

    assert Radikigo.lexu(teksto) == lexigoj

  end

  test "parse simple sentences" do

    teksto = "laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ"

    frazoj = [
      [
        vorto:  "laŭ",
        vorto:  "Ludoviko",
        vorto:  "Zamenhof",
        vorto:  "bongustas",
        vorto:  "freŝa",
        vorto:  "ĉeĥa",
        vorto:  "manĝaĵo",
        vorto:  "kun",
        vorto:  "spicoj",
        punkto: "."
      ],
      [
        vorto:  "LAŬ",
        vorto:  "LUDOVIKO",
        vorto:  "ZAMENHOF",
        vorto:  "BONGUSTAS",
        vorto:  "FREŜA",
        vorto:  "ĈEĤA",
        vorto:  "MANĜAĴO",
        vorto:  "KUN",
        vorto:  "SPICOJ"
      ]
    ]

    assert Radikigo.analazistu_teksto(teksto) == frazoj

  end

  test "parse quotes" do

    teksto = "aa bb \"cc dd. ee\" ff. gg"

    frazoj = [
      [
        vorto:  "aa",
        vorto:  "bb",
        quotes:  "\"",
        vorto:  "cc",
        vorto:  "dd",
        punkto: ".",
        vorto:  "ee",
        quotes:  "\"",
        vorto:  "ff",
        punkto: "."
      ],
      [
        vorto:  "gg",
      ]
    ]

    assert Radikigo.analazistu_teksto(teksto) == frazoj

  end


  test "break out sentences" do

    teksto = "La senpotencon pruvas la problemo de la medio. Kvar jarojn post la solenaj proklamoj de la COP 21, la lako jam defalis. La planedo de riĉuloj ne malaltigis siajn apetitojn de konsumado ; la riskoj de tro-varmiĝo preciziĝis. La socialista urbestrino de Parizo s-ino Anne Hidalgo, faras unu ekologian predikon post la alia, sed ŝi lasas la grandajn konstruaĵojn de la ĉefurbo briligi la gigantajn reklamlumojn de luksaj markoj aŭ de poŝtelefonoj. Kaj la franca ministro pri transporto ĝuas la promesplenajn karierojn en la sektoro de sia respondeco : “Ni bezonas tridek mil ŝoforojn en la venontaj jaroj, do tio estas metio, kiun oni devas valorigi, speciale ĉe junuloj.” Pli da ŝoforoj sur la stratoj, pli da “Macron-veturiloj”, jen kio protektas la ekologian sistemon. La fervoja vartransporto, la fervojo ? Ekster la demando, ĉar necesas batali kontraŭ la troa personaro en la publikaj entreprenoj."

    frazoj = [
      "La senpotencon pruvas la problemo de la medio.",
      "Kvar jarojn post la solenaj proklamoj de la COP 21, la lako jam defalis.",
      "La planedo de riĉuloj ne malaltigis siajn apetitojn de konsumado ; la riskoj de tro-varmiĝo preciziĝis.",
      "La socialista urbestrino de Parizo s-ino Anne Hidalgo, faras unu ekologian predikon post la alia, sed ŝi lasas la grandajn konstruaĵojn de la ĉefurbo briligi la gigantajn reklamlumojn de luksaj markoj aŭ de poŝtelefonoj.",
      "Kaj la franca ministro pri transporto ĝuas la promesplenajn karierojn en la sektoro de sia respondeco : “Ni bezonas tridek mil ŝoforojn en la venontaj jaroj, do tio estas metio, kiun oni devas valorigi, speciale ĉe junuloj.”",
      "Pli da ŝoforoj sur la stratoj, pli da “Macron-veturiloj”, jen kio protektas la ekologian sistemon.",
      "La fervoja vartransporto, la fervojo ?",
      "Ekster la demando, ĉar necesas batali kontraŭ la troa personaro en la publikaj entreprenoj."
    ]
    assert Radikigo.dividu_teksto(teksto) == frazoj

  end

  test "possesive_adjectives" do

    vortoj = [
    {"mia",         "mi"},    #-a possesive adjective
    {"miaj",        "mi"},    #-aj plural possesive adjective
    {"mian",        "mi"},    #-an accusative possesive adjective
    {"miajn",       "mi"},    #-ajn accusative plural possesive adjective
  ]
   for {v, r} <- vortoj do
     assert Radikigo.radikigu_vorto(v) == r
   end
  end

end
