require './person'
require './deck'
require './strategy'
Dir["./strategy/*.rb"].each {|file| require file }

class Game
  attr_accessor :deck, :player, :dealer, :last_hand, :silent

  SHOE_SIZE = 5 # number of decks in the dealer's shoe

  def initialize
    @silent = false
    self.deck = create_deck
    self.player = Player.new
    self.player.strategy = Strategy.new(self) #default player strategy
    self.dealer = Dealer.new("Dealer")
    self.dealer.strategy = DealerStrategy.new(self)

    @last_hand = false
  end

  def silent? 
    @silent
  end

  def deal
    if (@last_hand)
      self.deck = create_deck
      @last_hand = false
    end

    self.player.cards.clear
    self.dealer.cards.clear

    2.times do 
      self.player.cards << self.deck.pop
      puts player unless silent?
      self.dealer.cards << self.deck.pop
      puts dealer unless silent?
    end

    if (self.deck.size < SHOE_SIZE * 52 * 0.3) 
      puts "Last hand before a reshuffle!" unless silent?
      @last_hand = true
    end

  end

  #play out the hand based on the player's and the dealer's strategies
  #this returns the winner of the game
  def play
    return nil if player.blackjack? && dealer.blackjack?
    if player.blackjack?
      puts "Blackjack!" unless silent?
      return player
    end

    if player.blackjack?
      puts "Blackjack!" unless silent?
      return dealer
    end
    
    #player goes first
    play_hand(player)
    if (player.busted?)
      return dealer
    end

    play_hand(dealer) 
    if dealer.busted? || player.total > dealer.total
      return player
    end

    if (player.total == dealer.total)
      return nil #push
    end

    return dealer
  end

  def play_hand(player) 
    while(true)
      case player.strategy.action
      when :hit
        player.cards << deck.pop 
        puts "#{player.name} hits: #{player.cards.last}" unless silent?
      when :stand
        puts "#{player} stands" unless silent?
        break
      when :double_down, :split
        raise "You're too good, go to a real casino!"
      end


      if player.busted?
        puts "#{player} busted!" unless silent?
        break
      end
    end
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

  def create_deck
    cards = []
    SHOE_SIZE.times { cards += Deck.new}

    puts "Every day I'm shuffling..." unless silent?
    5.times { cards.shuffle! }  #just for good measure :)

    cards
  end

end
