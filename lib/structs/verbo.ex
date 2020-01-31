defmodule Verbo do
  # formo: [:infinitiva | :nuna | :futuro | :estinta | :kondiĉa | :imperativa | :participa]
  # voĉo: [activa | pasiva]
  # estis_partipo: [:jes | :ne]
  # estis_perfekto: [:jes | :ne]
  defstruct(formo: :infinitiva, voĉo: :activa, estis_partipo: :ne)
end
