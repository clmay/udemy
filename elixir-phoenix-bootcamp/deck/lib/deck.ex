defmodule Deck do
  @moduledoc """
    Provides methods for creating and handling a deck of playing cards,
    represented as a list of strings.
  """

  @doc """
    Creates a deck of cards.
  """
  def new do
    ranks = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Clubs", "Diamonds", "Hearts", "Spades"]

    for rank <- ranks, suit <- suits do
      "#{rank} of #{suit}"
    end
  end

  @doc """
    Shuffles a deck of cards.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether the deck contains a given card.
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Convenience function for dealing a hand from a new deck. Creates and
    shuffles a new deck, and deals the specified number of cards into a hand.
    Returns both the hand and the remainder of the deck.
  """
  def first_hand(hand_size) do
    Deck.new()
    |> Deck.shuffle()
    |> Deck.deal(hand_size)
  end

  @doc """
    Deals a hand from the deck, returning both the hand and the remainder of the
    deck. The `hand_size` argument indicates how many cards should be dealt to
    the hand.

  ## Examples
      iex> deck = Deck.new
      iex> {hand, deck} = Deck.deal(deck, 1)
      iex> hand
      ["Ace of Clubs"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck to a file.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a saved deck from a file.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end
end
