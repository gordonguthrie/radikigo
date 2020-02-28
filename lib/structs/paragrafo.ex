defmodule Paragrafo do
  # paragrafo:         string()
  # identaĵo:          hash()
  # intersekvo:        int()
  # neniu_de_vortoj:   int()
  # neniu_de_gravuloy: int()
  # radikigoj:         [radikigo()] | [vortoj()]
  defstruct(
    paragrafo:         "",
    identaĵo:          "",
    intersekvo:        0,
    neniu_de_vortoj:   0,
    neniu_de_gravuloy: 0,
    radikigoj:         []
  )
end
