defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand) do
    Enum.split(Cards.shuffle(deck), hand)
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
