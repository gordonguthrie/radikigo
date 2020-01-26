defmodule RadikigoTest do
  use ExUnit.Case
  doctest Radikigo

  test "possesive_adjectives" do

    vortoj = [
    {"mia",         "mi"},    #-a possesive adjective
    {"miaj",        "mi"},    #-aj plural possesive adjective
    {"mian",        "mi"},    #-an accusative possesive adjective
    {"miajn",       "mi"},    #-ajn accusative plural possesive adjective
  ]
   for {v, r} <- vortoj do
     assert Radikigo.radikigu_vorto(v) == r
   end
  end

end
