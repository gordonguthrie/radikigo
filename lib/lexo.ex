defmodule Lexo do
  use LexLuthor

  @alphabeto ~r/^[abcĉdefgĝhĥijĵklmnoprsŝtuŭvzABCĈDEFGĜHĤIJĴKLMNOPRSŜTUŬVZ]+/

  defrule @alphabeto,  fn(v)  -> {:vorto, v}     end
  defrule ~r/^\"/,     fn(_q) -> {:quotes, "\""} end
  defrule ~r/^\./,     fn(_p) -> {:punkto, "."}  end
  defrule ~r/^[ \t]+/, fn(_w) -> {:ws, " "}      end
  defrule ~r/^./,      fn(a)  -> {:any, a}       end

end
