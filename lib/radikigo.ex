defmodule Radikigo do

  @moduledoc """
  Copied from the Go Esperanto stemmer
  https://github.com/abadojack/stemmer
  """

  @doc """
  radikigo

  """

# roots represents standalone root words
@rakikogoj [
  "ĉar", "ĉi", "ĉu", "kaj", "ke", "la", "minus", "plus",
  	"se", "ĉe", "da", "de", "el", "ekster", "en", "ĝis", "je", "kun", "na",
  	"po", "pri", "pro", "sen", "tra", "ajn", "do", "ja", "jen", "ju", "ne",
  	"pli", "tamen", "tre", "tro", "ci", "ĝi", "ili", "li", "mi", "ni", "oni",
  	"ri", "si", "ŝi", "ŝli", "vi", "unu", "du", "tri", "kvin", "ĵus", "nun", "plu",
  	"tuj", "amen", "bis", "boj", "fi", "ha", "he", "ho", "hu", "hura", "nu", "ve",
  	"esperanto"]

# correlative roots
@koralatevoj [
  	"kia", "kial", "kiam", "kie", "kiel", "kies", "kio", "kiom", "kiu",
  	"tia", "tial", "tiam", "tie", "tiel", "ties", "tio", "tiom", "tiu",
  	"ia", "ial", "iam", "ie", "iel", "ies", "io", "iom", "iu",
  	"ĉia", "ĉial", "ĉiam", "ĉie", "ĉiel", "ĉies", "ĉio", "ĉiom", "ĉiu",
  	"nenia", "nenial", "neniam", "nenie", "neniel", "nenies", "nenio", "neniom", "neniu"
  ]

  # stem words
  def radikigu_vorto(vorto) when is_binary(vorto) do
    IO.inspect(vorto)
  end

end
