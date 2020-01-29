defmodule Lexo do
  use LexLuthor

  @alphabeto ~r/^[abcĉdefgĝhĥijĵklmnoprsŝtuŭvzABCĈDEFGĜHĤIJĴKLMNOPRSŜTUŬVZ]+/u

  defrule @alphabeto,         fn(v)  -> {:vorto,  v}    end
  defrule ~r/^['’‘]/u,        fn(_q) -> {:quote,  "'"}  end
  defrule ~r/^[\"“”»«„]/u,    fn(_q) -> {:quotes, "\""} end
  defrule ~r/^[\.\?]/u,       fn(p)  -> {:punkto, p}    end
  defrule ~r/^[[:space:]]+/u, fn(_w) -> {:ws,     " "}  end
  defrule ~r/^./u,            fn(a)  -> {:any,    a}    end

end
