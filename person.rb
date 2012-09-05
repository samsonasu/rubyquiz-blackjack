class Person
  attr_accessor :cards
  def initialize
    self.cards = []
  end

  def total
    total = 0
    self.cards.each do |card|
      total += card[:value]
    end
    return total
  end

  def hit(deck)
    self.cards << deck.pop 
    return deck
  end
end

class Player < Person
end

class Dealer < Person
end

