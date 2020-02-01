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

  @pronomo [
      "mi", "ci", "li", "ŝi", "ĝi", "ni", "vi", "ili", "oni","si"
    ]

@prefikso [
    "bo", "dis", "ek", "eks", "fi", "ge", "mal", "mis", "pra" ,"re"
    ]

@postfikso [
    "aĉ", "ad", "aĵ", "an", "ar", "ĉj", "nj",
    "ebl","ec", "eg", "em", "end", "er",
    "estr", "et", "ej", "foj", "id", "ig", "iĵ",
    "il","in", "ind", "ing", "ism", "ist", "nj",
    "obl", "on", "op", "uj", "ul", "um"
  ]

# correlative roots
@korelatevoj [
  	"kia",   "kial",   "kiam",   "kie",   "kiel",   "kies",   "kio",   "kiom",   "kiu",
  	"tia",   "tial",   "tiam",   "tie",   "tiel",   "ties",   "tio",   "tiom",   "tiu",
  	"ia",    "ial",    "iam",    "ie",    "iel",    "ies",    "io",    "iom",    "iu",
  	"ĉia",   "ĉial",   "ĉiam",   "ĉie",   "ĉiel",   "ĉies",   "ĉio",   "ĉiom",   "ĉiu",
  	"nenia", "nenial", "neniam", "nenie", "neniel", "nenies", "nenio", "neniom", "neniu"
  ]

  @korelatevoj2 [
    	"kien",
    	"tien",
    	"ien",
    	"ĉien",
    	"nenien"
    ]

  # stem words
  # we pass through a pipeline and just throw on match
  def radikigu_vorto(vorto) when is_binary(vorto) do
    unua_paso = try do
      vorto
      |> estis_radikigo?
      |> estis_pronomo?
      |> estis_korelatevo?
      |> estis_prepozicio?
      |> manipulu_unu_kaj_unuj
      |> adaptu_esti
      |> manipulu_poeziaĵo
      |> estis_ovorto?
      |> estis_avorto?
      |> estis_evorto?
      |> estis_verbo?

      throw({vorto, :netrovitis})
    catch
      p -> p
    end

    unua_paso
    |> estis_malperfekta?
    |> estis_participo?

  end

  defp estis_radikigo?(vorto) do
    case Enum.member?(@radikogoj, vorto) do
      true  -> throw({vorto, [:malgrandavorto]})
      false -> vorto
    end
  end

  defp estis_pronomo?(vorto) do
    for p <- @pronomo do
      case vorto do
        ^p ->
             throw({vorto, [%Pronomo{}]})
        _ ->
          lenp = String.length(p) - 1
          lenv = String.length(vorto) - 1
          if lenv > lenp do
            radikigo? = String.slice(vorto, 0..lenp)
            case Enum.member?(@pronomo, radikigo?) do
              true ->
                snip = String.slice(vorto, lenp + 1..lenv)
                case snip do
                  "a"   ->
                    throw({kurtigu(p, lenp), [%Pronomo{estis_poseda: :jes}]})
                  "an"  ->
                    throw({kurtigu(p, lenp), [%Pronomo{estis_poseda: :jes, kazo: :markita}]})
                  "aj"  ->
                    throw({kurtigu(p, lenp), [%Pronomo{estis_poseda: :jes, nombro: :jes}]})
                  "ajn" ->
                    throw({kurtigu(p, lenp), [%Pronomo{estis_poseda: :jes, kazo: :markita, nombro: :jes}]})
                  _ -> :ok
                end
              false ->
                :ok
              end
            end
      end
    end
    vorto
  end

  defp estis_korelatevo?(vorto) do
    case Enum.member?(@korelatevoj, vorto) do
      true  -> throw({vorto, [%Korelatevo{}]})
      false -> estis_k2(vorto)
    end
  end

  defp estis_k2(vorto) do
    case Enum.member?(@korelatevoj2, vorto) do
      true  -> throw({vorto, [%Korelatevo{kazo: :markita}]})
      false -> vorto
    end
  end

  defp estis_prepozicio?("la"),  do: throw({"la", [:malgrandavorto]})
  defp estis_prepozicio?("l'"),  do: throw({"la", [:malgrandavorto]})
  defp estis_prepozicio?(vorto), do: vorto

  defp manipulu_unu_kaj_unuj("un'"),  do: throw({"unu",  [:malgrandavorto]})
  defp manipulu_unu_kaj_unuj("unuj"), do: throw({"unuj", [:malgrandavorto]})
  defp manipulu_unu_kaj_unuj(vorto),  do: vorto

  defp adaptu_esti("'st" <> v), do: "est" <> v
  defp adaptu_esti(vorto),      do: vorto

  defp manipulu_poeziaĵo(vorto) do
    manipulu_p2(String.reverse(vorto))
  end

  defp manipulu_p2("'" <> v),   do: throw inversu({("o" <> v), [%Ovorto{}]})
  defp manipulu_p2(inversanta), do: inversu(inversanta)

  defp estis_ovorto?(vorto), do: estis_ov2(inversu(vorto))

  defp estis_ov2("njo" <> v), do: throw inversu({v, [%Ovorto{kazo: :markita,    nombro: :plura}]})
  defp estis_ov2("no"  <> v), do: throw inversu({v, [%Ovorto{kazo: :markita,    nombro: :sola}]})
  defp estis_ov2("jo"  <> v), do: throw inversu({v, [%Ovorto{kazo: :malmarkita, nombro: :plura}]})
  defp estis_ov2("o"   <> v), do: throw inversu({v, [%Ovorto{kazo: :malmarkita, nombro: :sola}]})
  defp estis_ov2(inversanta), do: inversu(inversanta)

  defp estis_avorto?(vorto), do: estis_av2(inversu(vorto))

  defp estis_av2("nja" <> v), do: throw inversu({v, [%Avorto{kazo: :markita,    nombro: :plura}]})
  defp estis_av2("na"  <> v), do: throw inversu({v, [%Avorto{kazo: :markita,    nombro: :sola}]})
  defp estis_av2("ja"  <> v), do: throw inversu({v, [%Avorto{kazo: :malmarkita, nombro: :plura}]})
  defp estis_av2("a"   <> v), do: throw inversu({v, [%Avorto{kazo: :malmarkita, nombro: :sola}]})
  defp estis_av2(inversanta), do: inversu(inversanta)

  defp estis_evorto?(vorto), do: estis_ev2(inversu(vorto))

  defp estis_ev2("ne" <> v), do: throw inversu({v, [%Evorto{kazo: :markita}]})
  defp estis_ev2("e"  <> v), do: throw inversu({v, [%Evorto{kazo: :malmarkita}]})
  defp estis_ev2(inversanta), do: inversu(inversanta)

  defp estis_verbo?(vorto), do: estis_v2(inversu(vorto))

  defp estis_v2("i"  <> v),  do: throw inversu({v, [%Verbo{formo: :infinitiva}]})
  defp estis_v2("sa" <> v),  do: throw inversu({v, [%Verbo{formo: :nuna}]})
  defp estis_v2("so" <> v),  do: throw inversu({v, [%Verbo{formo: :futuro}]})
  defp estis_v2("si" <> v),  do: throw inversu({v, [%Verbo{formo: :estinta}]})
  defp estis_v2("su" <> v),  do: throw inversu({v, [%Verbo{formo: :kondiĉa}]})
  defp estis_v2("u"  <> v),  do: throw inversu({v, [%Verbo{formo: :imperativa}]})
  defp estis_v2(inversanta), do: inversu(inversanta)

  defp estis_malperfekta?({vorto, detaletoj}) do
    estis_malp2(inversu(vorto), detaletoj)
  end

  defp estis_malp2("da" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_perfekto: :ne}]}
  end
  defp estis_malp2("da" <> v, [%Ovorto{} = detaletoj]) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_perfekto: :ne}, detaletoj]}
  end
  defp estis_malp2(v, detaletoj) do
    {inversu(v),  detaletoj}
  end

  defp estis_participo?({vorto, detaletoj}) do
    estis_p2(inversu(vorto), detaletoj)
  end

  defp estis_p2("ta" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]}
  end
  defp estis_p2("to" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]}
  end
  defp estis_p2("ti" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]}
  end
  defp estis_p2("tna" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, aspecto: :ekestiĝa}]}
  end
  defp estis_p2("tno" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, aspecto: :finita}]}
  end
  defp estis_p2("tni" <> v, [%Verbo{} = detaletoj]) do
    {inversu(v), [%Verbo{detaletoj | estis_partipo: :jes, aspecto: :anticipa}]}
  end
  defp estis_p2("ta" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa} | detaletoj]}
  end
  defp estis_p2("to" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :finita}   | detaletoj]}
  end
  defp estis_p2("ti" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa} | detaletoj]}
  end
  defp estis_p2("tna" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, aspecto: :ekestiĝa} | detaletoj]}
  end
  defp estis_p2("tno" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, aspecto: :finita}   | detaletoj]}
  end
  defp estis_p2("tni" <> v, detaletoj) do
    {inversu(v), [%Verbo{formo: :radikigo, estis_partipo: :jes, aspecto: :anticipa} | detaletoj]}
  end
  defp estis_p2(v, detaletoj) do
    {inversu(v),  detaletoj}
  end


#
# Helper fns
#

  defp kurtigu(vorto, n) do
    String.slice(vorto, 0..n)
  end

  defp inversu({vorto, tipo}) when is_binary(vorto) and is_list(tipo) do
    {String.reverse(vorto), tipo}
  end

  defp inversu(vorto) when is_binary(vorto) do
    String.reverse(vorto)
  end

end
