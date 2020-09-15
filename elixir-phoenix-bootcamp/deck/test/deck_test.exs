defmodule DeckTest do
  use ExUnit.Case
  doctest Deck

  test "a new deck has 52 cards" do
    assert length(Deck.new()) == 52
  end

  test "dealt hand has correct size" do
    hand_size = Enum.random(52)
    {hand, _deck} = Deck.first_hand(hand_size)
    assert length(hand) == hand_size
  end

  test "after dealing a hand, remaining deck has correct size" do
    hand_size = Enum.random(52)
    {_hand, deck} = Deck.first_hand(hand_size)
    assert length(deck) == 52 - hand_size
  end
end
