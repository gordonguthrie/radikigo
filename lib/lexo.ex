defmodule Lexo do
  use LexLuthor

  @alphabeto ~r/^[abcĉdefgĝhĥijĵklmnoprsŝtuŭvzABCĈDEFGĜHĤIJĴKLMNOPRSŜTUŬVZ]+/u

  defrule @alphabeto,         fn(v)  -> {:vorto,  {v,    String.length(v)}} end
  defrule ~r/^['’‘]/u,        fn(_q) -> {:quote,  {"'",  1}}                end
  defrule ~r/^[\"“”»«„]/u,    fn(_q) -> {:quotes, {"\"", 1}}                end
  defrule ~r/^[\.\?]/u,       fn(p)  -> {:punkto, {p,    1}}                end
  defrule ~r/^[[:space:]]+/u, fn(w)  -> {:ws,     {" ",  String.length(w)}} end
  defrule ~r/^./u,            fn(a)  -> {:any,    {a,    1}}                end

end
