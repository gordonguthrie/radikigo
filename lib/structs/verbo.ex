defmodule Verbo do
  # formo: [:infinitiva | :nuna | :futuro | :estinta | :kondiĉa | :imperativa | :participa | :radikigo]
  # voĉo: [activa | pasiva]
  # aspecto: [:nil | :ekestiĝa | :finita | :anticipa]
  # estas_partipo: [:jes | :ne]
  # estas_perfekto: [:jes | :ne]
  defstruct(formo:          :infinitiva,
            voĉo:           :aktiva,
            aspecto:        :nil,
            estas_partipo:  :ne,
            estas_perfekto: :jes)
end
