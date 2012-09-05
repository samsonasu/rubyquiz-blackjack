require './person'
class Game
  attr_accessor :deck, :player, :dealer

  def initialize
    self.deck = create_deck
    shuffle

    self.player = Player.new
    self.dealer = Dealer.new

  end

  def deal
    self.player.cards << self.deck.pop
    puts "player cards: #{self.player.cards}"
    self.player.cards << self.deck.pop
    puts "player cards: #{self.player.cards}"
    self.dealer.cards << self.deck.pop
    puts "dealer cards: #{self.dealer.cards}"
    self.dealer.cards << self.deck.pop
    puts "dealer cards: #{self.dealer.cards}"
  end

  def round
    if player.total < 17
      self.deck = player.hit(self.deck)
    elsif player.total >= 21
      player.bust
    else
      player.stand
    end
    if dealer.total < 17
      self.deck = dealer.hit(self.deck)
    elsif dealer.total >= 21
      dealer.bust
    else
      dealer.stand
    end
  end

  def shuffle
    self.deck.shuffle!
  end

  def create_deck
    suits = ["hearts","spades","clubs","diamonds"]
    cards = []
    suits.each do |suit|
      cards << {:value => 1,   :suit => suit, :card => "ace"}
      cards << {:value => 2,   :suit => suit, :card => "2"}
      cards << {:value => 3,   :suit => suit, :card => "3"}
      cards << {:value => 4,   :suit => suit, :card => "4"}
      cards << {:value => 5,   :suit => suit, :card => "5"}
      cards << {:value => 6,   :suit => suit, :card => "6"}
      cards << {:value => 7,   :suit => suit, :card => "7"}
      cards << {:value => 8,   :suit => suit, :card => "8"}
      cards << {:value => 9,   :suit => suit, :card => "9"}
      cards << {:value => 10,  :suit => suit, :card => "10"}
      cards << {:value => 10,  :suit => suit, :card => "jack"}
      cards << {:value => 10,  :suit => suit, :card => "queen"}
      cards << {:value => 10,  :suit => suit, :card => "king"}
    end
    return cards
  end
end

