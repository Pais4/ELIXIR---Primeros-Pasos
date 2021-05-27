defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  #Test -> Descripcion del test
  test "create_deck makes 20 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 20
  end

  #Test para garantizar que shuffle este haciendo su trabajo
  test "Shuffling a deck randimizes it" do
    deck = Cards.create_deck
    #Refute espera que se refute el comportamiento del codigo.
    refute deck == Cards.shuffle(deck)
  end
  
end
