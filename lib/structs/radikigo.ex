defmodule Radikigo do
  # vorto: string()
  # radikigo: string()
  # detaletoj: [avorto(), evorto(), ovorto(), pronomo(), verbo(), :krokodilo, :malgranda]
  # afiksoj: [affixo()]
  # ekesto: int()
  # longaĵo: int()
  defstruct(vorto: "", radikigo: "", detaletoj: [], afiksoj: [],
            ekesto: 0, longaĵo: 0)
end
