defmodule Radikigoj do

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
    "mi", "ci", "li", "ŝi", "ĝi", "ni", "vi", "ili", "oni", "si"
  ]

@prefikso2 [
             "bo",  "ek",  "fi", "ge", "re"
           ]

@prefikso3 [
             "dis", "eks", "mal", "mis", "pra"
           ]

@falsa_afikso [
                  "bon"
                ]

# note that "ad" is treated seperately as a postfix
@postfikso2 [
    "aĉ", "ad", "aĵ", "an", "ar",
    "ec", "eg", "em", "er", "et", "ej",
    "id", "ig", "iĝ", "ik", "il", "iv",
    "in", "on", "op", "oz",
    "uj", "ul", "um"
  ]

@postfikso3 [
    "ebl", "end", "esk", "foj", "ind", "ing", "ism", "ist", "obl"
  ]

@postfikso4 ["estr", "olog"]

@kerasnomo ["ĉj", "nj"]

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
  def radikigu_vorto_TEST(vorto) when is_binary(vorto) do

    afiksa_vortaro = Vorto.akiru_malvera_afikso_vortaro()
    radikigu_vorto(vorto, afiksa_vortaro)
  end

  def radikigu_vorto(vorto, afiksa_vortaro) do
    efiko = try do
      vorto
      |> estas_radikigo?
      |> estas_pronomo?
      |> estas_korelatevo?
      |> estas_prepozicio?
      |> manipulu_unu_kaj_unuj
      |> adaptu_esti
      |> manipulu_poeziaĵo
    catch
      p -> {:exit, p}
    end
    case efiko do
      {:exit, {radikio, detaletoj}} -> {radikio, detaletoj, []}
      _                             -> radikigu_vorto2(efiko, afiksa_vortaro)
    end
  end

defp radikigu_vorto2(vorto, afiksa_vortaro) do
  dua_paso = try do
    vorto
    |> estas_ovorto?
    |> estas_avorto?
    |> estas_evorto?
    |> estas_verbo?
    |> estas_krokodilo?
  catch
    p ->
      p
  end

  _tria_paso = try do
    dua_paso
      |> estas_malperfekta?
      |> estas_participo?
      |> adicu
      |> havas_malvera_afikso?(afiksa_vortaro)
      |> havas_prefikso?
      |> havas_postfikso?
    catch
      p ->
        p
    end

  end

  defp estas_radikigo?(vorto) do
    case Enum.member?(@radikogoj, vorto) do
      true  -> throw({vorto, [:malgrandavorto]})
      false -> vorto
    end
  end

  defp estas_pronomo?(vorto) do
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
                    throw({kurtigu(p, lenp), [%Pronomo{estas_poseda: :jes}]})
                  "an"  ->
                    throw({kurtigu(p, lenp), [%Pronomo{estas_poseda: :jes, kazo: :markita}]})
                  "aj"  ->
                    throw({kurtigu(p, lenp), [%Pronomo{estas_poseda: :jes, nombro: :plura}]})
                  "ajn" ->
                    throw({kurtigu(p, lenp), [%Pronomo{estas_poseda: :jes, kazo: :markita, nombro: :plura}]})
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

  defp estas_korelatevo?(vorto) do
    case Enum.member?(@korelatevoj, vorto) do
      true  -> throw({vorto, [%Korelatevo{}]})
      false -> estas_k2(vorto)
    end
  end

  defp estas_k2(vorto) do
    case Enum.member?(@korelatevoj2, vorto) do
      true  -> throw({vorto, [%Korelatevo{kazo: :markita}]})
      false -> vorto
    end
  end

  defp estas_prepozicio?("la"),  do: throw({"la", [:malgrandavorto]})
  defp estas_prepozicio?("l'"),  do: throw({"la", [:malgrandavorto]})
  defp estas_prepozicio?(vorto), do: vorto

  defp manipulu_unu_kaj_unuj("un'"),  do: throw({"unu",  [:malgrandavorto]})
  defp manipulu_unu_kaj_unuj("unuj"), do: throw({"unuj", [:malgrandavorto]})
  defp manipulu_unu_kaj_unuj(vorto),  do: vorto

  defp adaptu_esti("'st" <> v), do: "est" <> v
  defp adaptu_esti(vorto),      do: vorto

  defp manipulu_poeziaĵo(vorto) do
    manipulu_p2(String.reverse(vorto))
  end

  defp manipulu_p2("'" <> v),   do: throw inversu({(v), [%Ovorto{}]})
  defp manipulu_p2(inversanta), do: inversu(inversanta)

  defp estas_ovorto?(vorto), do: estas_ov2(inversu(vorto))

  defp estas_ov2("njo" <> v), do: throw inversu({v, [%Ovorto{kazo: :markita,    nombro: :plura}]})
  defp estas_ov2("no"  <> v), do: throw inversu({v, [%Ovorto{kazo: :markita,    nombro: :sola}]})
  defp estas_ov2("jo"  <> v), do: throw inversu({v, [%Ovorto{kazo: :malmarkita, nombro: :plura}]})
  defp estas_ov2("o"   <> v), do: throw inversu({v, [%Ovorto{kazo: :malmarkita, nombro: :sola}]})
  defp estas_ov2(inversanta), do: inversu(inversanta)

  defp estas_avorto?(vorto), do: estas_av2(inversu(vorto))

  defp estas_av2("nja" <> v), do: throw inversu({v, [%Avorto{kazo: :markita,    nombro: :plura}]})
  defp estas_av2("na"  <> v), do: throw inversu({v, [%Avorto{kazo: :markita,    nombro: :sola}]})
  defp estas_av2("ja"  <> v), do: throw inversu({v, [%Avorto{kazo: :malmarkita, nombro: :plura}]})
  defp estas_av2("a"   <> v), do: throw inversu({v, [%Avorto{kazo: :malmarkita, nombro: :sola}]})
  defp estas_av2(inversanta), do: inversu(inversanta)

  defp estas_evorto?(vorto), do: estas_ev2(inversu(vorto))

  defp estas_ev2("ne" <> v), do: throw inversu({v, [%Evorto{kazo: :markita}]})
  defp estas_ev2("e"  <> v), do: throw inversu({v, [%Evorto{kazo: :malmarkita}]})
  defp estas_ev2(inversanta), do: inversu(inversanta)

  defp estas_verbo?(vorto), do: estas_v2(inversu(vorto))

  defp estas_v2("i"  <> v),  do: throw inversu({v, [%Verbo{formo: :infinitiva}]})
  defp estas_v2("sa" <> v),  do: throw inversu({v, [%Verbo{formo: :nuna}]})
  defp estas_v2("so" <> v),  do: throw inversu({v, [%Verbo{formo: :futuro}]})
  defp estas_v2("si" <> v),  do: throw inversu({v, [%Verbo{formo: :estinta}]})
  defp estas_v2("su" <> v),  do: throw inversu({v, [%Verbo{formo: :kondiĉa}]})
  defp estas_v2("u"  <> v),  do: throw inversu({v, [%Verbo{formo: :imperativa}]})
  defp estas_v2(inversanta), do: inversu(inversanta)

  defp estas_krokodilo?({radikigo, detaletoj}) do
    {radikigo, detaletoj}
  end
  defp estas_krokodilo?(radikigo) do
    {radikigo, [:krokodilo]}
  end

  defp estas_malperfekta?({radikigo, detaletoj}) do
    estas_malp2(inversu(radikigo), detaletoj)
  end

  defp estas_malp2("da" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_perfekto: :ne}]}
  end
  defp estas_malp2("da" <> r, [%Ovorto{} = detaletoj]) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_perfekto: :ne}, detaletoj]}
  end
  defp estas_malp2(r, detaletoj) do
    {inversu(r),  detaletoj}
  end

  defp estas_participo?({radikigo, detaletoj}) do
    estas_p2(inversu(radikigo), detaletoj)
  end

  defp estas_p2("ta" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa}]}
  end
  defp estas_p2("to" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}]}
  end
  defp estas_p2("ti" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa}]}
  end
  defp estas_p2("tna" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, aspecto: :ekestiĝa}]}
  end
  defp estas_p2("tno" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, aspecto: :finita}]}
  end
  defp estas_p2("tni" <> r, [%Verbo{} = detaletoj]) do
    {inversu(r), [%Verbo{detaletoj | estas_partipo: :jes, aspecto: :anticipa}]}
  end
  defp estas_p2("ta" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :ekestiĝa} | detaletoj]}
  end
  defp estas_p2("to" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :finita}   | detaletoj]}
  end
  defp estas_p2("ti" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, voĉo: :pasiva, aspecto: :anticipa} | detaletoj]}
  end
  defp estas_p2("tna" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, aspecto: :ekestiĝa} | detaletoj]}
  end
  defp estas_p2("tno" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, aspecto: :finita}   | detaletoj]}
  end
  defp estas_p2("tni" <> r, detaletoj) do
    {inversu(r), [%Verbo{formo: :radikigo, estas_partipo: :jes, aspecto: :anticipa} | detaletoj]}
  end
  defp estas_p2(r, detaletoj) do
    {inversu(r),  detaletoj}
  end

  def adicu({radikigo, detaletoj}) do
    {radikigo, detaletoj, []}
  end

  defp havas_malvera_afikso?({radikigo, detaletoj, afiksoj}, afiksa_vortaro) do
    case :dict.is_key(radikigo, afiksa_vortaro) do
      true  -> throw({radikigo, detaletoj, afiksoj})
      false -> {radikigo, detaletoj, afiksoj}
    end
  end

  defp havas_prefikso?({radikigo, detaletoj, afiksoj}) do
    case Enum.member?(@falsa_afikso, radikigo) do
      true ->
        {radikigo, detaletoj, afiksoj}
      false ->
        eblaprefikso2 = String.slice(radikigo, 0..1)
        eblaprefikso3 = String.slice(radikigo, 0..2)
        case {Enum.member?(@prefikso2, eblaprefikso2), Enum.member?(@prefikso3, eblaprefikso3)} do
          # ONLY happens with 'ek' and 'eks'
          # if it is being used as a verb go with `ek` otherwise go with 'eks'
          {true, true} ->
            case havas_verbo?(detaletoj) do
              true ->
                forigu_prefikso(radikigo, eblaprefikso2, 2, detaletoj, afiksoj)
              false ->
                forigu_prefikso(radikigo, eblaprefikso3, 3, detaletoj, afiksoj)
            end
          {true, false} ->
            forigu_prefikso(radikigo, eblaprefikso2, 2, detaletoj, afiksoj)
          {false, true} ->
            forigu_prefikso(radikigo, eblaprefikso3, 3, detaletoj, afiksoj)
          {false, false} ->
            {radikigo, detaletoj, afiksoj}
        end
    end
  end

  defp havas_postfikso?({radikigo, detaletoj, afiksoj}) do
    case Enum.member?(@falsa_afikso, radikigo) do
      true ->
        {radikigo, detaletoj, afiksoj}
      false ->
          i = inversu(radikigo)
          eblapostfikso2 = inversu(String.slice(i, 0..1))
          case Enum.member?(@kerasnomo, eblapostfikso2) do
            true ->
              novadetaletoj = marku_karesnomi(detaletoj)
              {radikigo <> "o", novadetaletoj, afiksoj}
            false ->
              eblapostfikso3 = inversu(String.slice(i, 0..2))
              eblapostfikso4 = inversu(String.slice(i, 0..3))
              estas_postfikso2 = Enum.member?(@postfikso2, eblapostfikso2)
              estas_postfikso3 = Enum.member?(@postfikso3, eblapostfikso3)
              estas_postfikso4 = Enum.member?(@postfikso4, eblapostfikso4)
              case {estas_postfikso2, estas_postfikso3, estas_postfikso4} do
                {true, false, false} ->
                  forigu_postfikso(radikigo, 2, detaletoj, afiksoj)
                {false, true, false} ->
                  forigu_postfikso(radikigo, 3, detaletoj, afiksoj)
                {false, false, true} ->
                  forigu_postfikso(radikigo, 4, detaletoj, afiksoj)
                {false, false, false} ->
                  {radikigo, detaletoj, afiksoj}
              end
            end
        end
  end

#
# Helper fns
#

  defp havas_verbo?([]),              do: false
  defp havas_verbo?([%Verbo{} | _v]), do: true
  defp havas_verbo?([_k       | v]),  do: havas_verbo?(v)

  defp kurtigu(vorto, n) do
    String.slice(vorto, 0..n)
  end

  defp inversu({vorto, tipo}) when is_binary(vorto) and is_list(tipo) do
    {String.reverse(vorto), tipo}
  end

  defp inversu(vorto) when is_binary(vorto) do
    String.reverse(vorto)
  end

  defp forigu_prefikso(radikigo, prefikso, nomero, detaletoj, afiksoj) do
    len = String.length(radikigo) - 1
    novaradikigo = String.slice(radikigo, nomero..len)
    nombraafiksoj = length(afiksoj)
    novaafiksoj = [%Afikso{prefikso: prefikso, nombro: nombraafiksoj + 1} | afiksoj]
    havas_prefikso?{novaradikigo, detaletoj, novaafiksoj}
  end

  defp marku_karesnomi(detaletoj), do: marku_k2(detaletoj, [])

  defp marku_k2([], a),                  do: Enum.reverse(a)
  defp marku_k2([%Ovorto{} = o | v], a), do: Enum.reverse(a) ++ [%Ovorto{o | estas_karesnomo: :jes}] ++ v
  defp marku_k2([k | v], a),             do: marku_k2(v, [k | a])

  defp forigu_postfikso(radikigo, nomero, detaletoj, afiksoj) do
    len = String.length(radikigo) - 1
    postfikso = String.slice(radikigo, (len - nomero + 1)..len)
    if (len - nomero > 0) do
      novaradikigo = String.slice(radikigo, 0..(len - nomero))
      nombraafiksoj = length(afiksoj)
      novaafiksoj = [%Afikso{postfikso: postfikso, nombro: nombraafiksoj + 1} | afiksoj]
      havas_postfikso?({novaradikigo, detaletoj, novaafiksoj})
    else
      {radikigo, detaletoj, afiksoj}
    end
  end

end
