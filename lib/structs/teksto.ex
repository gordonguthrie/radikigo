defmodule Teksto do
  # titola: string()
  # url: string()
  # alŝutota_daktilo: timestamp()
  # alŝutano: userid()
  # paragrajoj: [paragrafo()]
  defstruct(titola: "", url: "", alŝutota_daktilo: "", alŝutano: "", paragrafoj: [])
end
