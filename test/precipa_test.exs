defmodule PrecipaTest do
  use ExUnit.Case
  doctest Precipa

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

    assert Precipa.lexu(teksto) == lexigoj

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

    assert Precipa.analazistu_teksto(teksto) == frazoj

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

    assert Precipa.analazistu_teksto(teksto) == frazoj

  end

  test "replace x accents" do
    maljuna = "laux Ludoviko Zamenhof bongustas fresxa cxehxa mangxajxo kun spicoj. lauX Ludoviko Zamenhof bongustas fresXa cXehXa mangXajXo kun spicoj. LAUX LUDOVIKO ZAMENHOF BONGUSTAS FRESXA CXEHXA MANGXAJXO KUN SPICOJ. LAUx LUDOVIKO ZAMENHOF BONGUSTAS FRESxA CxEHxA MANGxAJxO KUN SPICOJ. lauh Ludoviko Zamenhof bongustas fresha chehha manghajho kun spicoj. lauH Ludoviko Zamenhof bongustas fresHa cHehHa mangHajHo kun spicoj. LAUH LUDOVIKO ZAMENHOF BONGUSTAS FRESHA CHEHHA MANGHAJXO KUN SPICOJ. LAUh LUDOVIKO ZAMENHOF BONGUSTAS FREShA ChEHhA MANGhAJhO KUN SPICOJ."

    juna = "laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ. laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. laŭ Ludoviko Zamenhof bongustas freŝa ĉeĥa manĝaĵo kun spicoj. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ. LAŬ LUDOVIKO ZAMENHOF BONGUSTAS FREŜA ĈEĤA MANĜAĴO KUN SPICOJ."

    assert Precipa.preparu_alfabeto(maljuna) == juna

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
    assert Precipa.dividu_teksto(teksto) == frazoj

  end

end
