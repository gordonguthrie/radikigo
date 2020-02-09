defmodule Radikigo do
  # vorto: string()
  # radikigo: string()
  # detaletoj: [avorto(), evorto(), ovorto(), pronomo(), verbo(), :krokodilo, :malgranda]
  # afiksoj: [affixo()]
  # ekesto: int()
  # longaĵo: int()
  # estas_vortarero?: [jes | ne]
  defstruct(vorto: "", radikigo: "", detaletoj: [], afiksoj: [],
            ekesto: 0, longaĵo: 0, estas_vortarero?: :ne)
end
