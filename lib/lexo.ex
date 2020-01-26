defmodule Lexo do
  use LexLuthor

  defrule ~r/^[abcĉdefgĝhĥijĵklmnoprsŝtuŭvzABCĈDEFGĜHĤIJĴKLMNOPRSŜTUŬVZ]+/, fn(v) -> {:vorto, v}  end
  defrule ~r/^\"/,                                                        fn(q) -> {:quotes, q} end
  defrule ~r/^\./,                                                        fn(p) -> {:punkto, p} end
  defrule ~r/^[ \t]+/,                                                    fn(w) -> {:ws, " "}   end
  defrule ~r/^./,                                                         fn(a) -> {:any, a}    end

end
