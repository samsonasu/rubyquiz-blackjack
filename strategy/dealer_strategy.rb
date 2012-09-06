class DealerStrategy < Strategy
  def initialize(game)
    super(game)
    @dealer = game.dealer
  end

  #dealer stands on soft 17
  def action
   if @dealer.total <= 16
      :hit
    else
      :stand
    end
  end
end