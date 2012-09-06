#basic strategy based on the card at http://en.wikipedia.org/wiki/Blackjack#Blackjack_strategy
#someone should implement double down, etc
class WikipediaStrategy < Strategy
  def initialize(game)
    super(game)
    @dealer = game.dealer
  end


  def action
    dealer_card = @dealer.cards.first[:value] #we can see the dealer's first card 
    total = @player.total
    
    #do we have a soft ace?
    if (@player.soft?)
      if (total >= 18 && dealer_card < 9)
        return :stand
      else
        return :hit
      end
    end

    #hard rules
    if @player.total >= 17
      return :stand
    end

    if (@player.total >= 13)
      if (dealer_card >=7) 
        return :hit
      else
        return :stand
      end
    end

    if (@player.total == 12)
      if (4..6).include? dealer_card
        return :stand
      else
        return :hit
      end
    end

    return :hit
  end
end