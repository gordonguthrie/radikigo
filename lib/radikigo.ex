defmodule Radikigo do

  @moduledoc """
  Copied from the Go Esperanto stemmer
  https://github.com/abadojack/stemmer
  """

  @doc """
  radikigo

  """

# roots represents standalone root words
@radikogoj [
   "ajn",
   "amen",
   "bis",
   "boj",
   "ĉar",
   "ĉe",
   "ĉi",
   "ĉu",
   "da",
   "de",
   "do",
   "du",
   "el",
   "ekster",
   "en",
   "esperanto",
   "fi",
   "ĝis",
   "ha",
   "he",
   "ho",
   "hu",
   "hura",
   "ja",
   "je",
   "jen",
   "ju",
   "ĵus",
   "kaj",
   "ke",
   "kun",
   "kvin",
   "la",
   "minus",
   "na",
   "ne",
   "nu",
   "nun",
   "po",
   "pri",
   "pro",
   "pli",
   "plu",
   "plus",
   "ri",
   "se",
   "sen",
   "ŝli",
   "tamen",
   "tra",
   "tre",
   "tri",
   "tro",
   "tuj",
   "unu",
   "ve"
]

@pronomo [
    "mi", "ci", "li", "ŝi", "ĝi", "ni", "vi", "ili", "oni","si"
  ]

@prefikso [
    "bo", "dis", "ek", "eks", "fi", "ge", "mal", "mis", "pra" ,"re"
  ]

@postfikso [
    "aĉ", "ad", "aĵ", "an", "ar", "ĉj", "nj", "ebl", "ec", "eg", "em", "end", "er",
    "estr", "et", "ej", "foj", "id", "il", "in", "ind", "ing", "ism", "ist", "nj",
    "obl", "on", "op", "uj", "ul", "um"
  ]

# correlative roots
@koralatevoj [
  	"kia",   "kial",   "kiam",   "kie",   "kiel",   "kies",   "kio",   "kiom",   "kiu",
  	"tia",   "tial",   "tiam",   "tie",   "tiel",   "ties",   "tio",   "tiom",   "tiu",
  	"ia",    "ial",    "iam",    "ie",    "iel",    "ies",    "io",    "iom",    "iu",
  	"ĉia",   "ĉial",   "ĉiam",   "ĉie",   "ĉiel",   "ĉies",   "ĉio",   "ĉiom",   "ĉiu",
  	"nenia", "nenial", "neniam", "nenie", "neniel", "nenies", "nenio", "neniom", "neniu"
  ]

  # stem words
  # we pass through a pipeline and just throw on match
  def radikigu_vorto(vorto) when is_binary(vorto) do
    try do
      vorto
      |> estis_radiko?
      |> estis_pronomo?
      |> estis_prepozicio?
      throw({vorto, :netrovitis})
    catch
      p -> p
    end
  end

  defp estis_prepozicio?("la"), do: throw({"la", :malgrandavorto})
  defp estis_prepozicio?("l'"), do: throw({"la", :malgrandavorto})

  defp estis_radiko?(vorto) do
    case Enum.member?(@radikogoj, vorto) do
      true  -> throw({vorto, :malgrandavorto})
      false -> vorto
    end
  end

  defp estis_pronomo?(vorto) do
    case Enum.member?(@pronomo, vorto) do
      true  -> throw({vorto, %Pronomo{}})
      false -> vorto
    end
  end

end
