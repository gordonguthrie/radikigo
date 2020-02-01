defmodule Verbo do
  # formo: [:infinitiva | :nuna | :futuro | :estinta | :kondiĉa | :imperativa | :participa | :radikigo]
  # voĉo: [activa | pasiva]
  # aspecto: [:nil | :ekestiĝa | :finita | :anticipa]
  # estis_partipo: [:jes | :ne]
  # estis_perfekto: [:jes | :ne]
  defstruct(formo:          :infinitiva,
            voĉo:           :aktiva,
            aspecto:        :nil,
            estis_partipo:  :ne,
            estis_perfekto: :jes)
end
