defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a dec of cards
  """
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Determines whether a deck contains a given card
  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end


  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.
  ## Examples
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand) do
    Enum.split(deck, hand)
  end

  def create_hand(hand) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand)
  end

  def save(deck, fileName) do
    binary = :erlang.term_to_binary(deck)
    File.write(fileName, binary)
  end

  def load(fileName) do
    case File.read(fileName) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File '#{fileName}' doesn't exists"
    end
  end
end
