require './strategy'
class Person
  attr_accessor :cards, :strategy, :name
  def initialize(name="Player")
    self.cards = []
    self.name = name
  end

  def total
    total = 0
    self.cards.each do |card|
      total += card[:value]
    end
    return total
  end

  def blackjack?
    cards.size == 2 && total == 21
  end

  #returns a soft ace in the hand or nil
  def soft?
    self.cards.each do |card|
      return card if card.soft_ace?
    end
    nil
  end

  def busted?
    if (total > 21)
      ace = soft?
      if (ace)
        ace[:value] = 1
        return false
      end
      return true
    end

    false
  end

  def to_s
    "#{self.name} #{self.cards} (#{self.total})"
  end
end

class Player < Person
end

class Dealer < Person
end

