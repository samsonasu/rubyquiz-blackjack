require './black_jack'
require './person'

describe "Game" do
  it 'has 4 suits' do
    deck = Game.new().deck
    suits = []
    deck.each do |card|
      suits << card[:suit]
    end
    suits.uniq.count.should eql 4
  end

  it 'generates a deck on new' do
    card_deck = Game.new().deck
    card_deck.count.should eql 52
  end

  describe "Game Play" do
    before(:each) do
      @game = Game.new()
    end

    it 'has two players' do
      @game.player.class.should eql Player.new.class 
      @game.dealer.class.should eql Dealer.new.class
    end

    it 'deals two cards to each player' do
      @game.deal
      @game.player.cards.count.should eql 2
      @game.dealer.cards.count.should eql 2
    end

    it 'has a total for each player' do  
      sample_deck =[{:value => 2,   :suit => "hearts", :card => "2"},
                    {:value => 3,   :suit => "hearts", :card => "3"},
                    {:value => 4,   :suit => "hearts", :card => "4"},
                    {:value => 5,   :suit => "hearts", :card => "5"}]


      game = Game.new()
      game.stub(:deck).and_return(sample_deck)
      game.stub(:shuffle).and_return(sample_deck)

      game.deal

      game.player.total.should eql 9
      game.dealer.total.should eql 5
    end
    
    describe "a round" do
      before(:each) do
        sample_deck =[{:value => 2,   :suit => "hearts", :card => "2"},
                      {:value => 3,   :suit => "hearts", :card => "3"},
                      {:value => 4,   :suit => "hearts", :card => "4"},
                      {:value => 5,   :suit => "hearts", :card => "5"},
                      {:value => 6,   :suit => "hearts", :card => "6"},
                      {:value => 7,   :suit => "hearts", :card => "7"}]
        @game = Game.new()
        @game.stub(:deck).and_return(sample_deck)
        @game.stub(:shuffle).and_return(sample_deck)
        @game.deal
      end
      it 'hit should add another card' do
        @game.round
        @game.player.cards.count.should eql 3
        @game.dealer.cards.count.should eql 3
      end

      it 'calls hit if the current total is less than 17' do
        @game.player.should_receive(:hit)
        @game.dealer.should_receive(:hit)
        @game.round
      end

      it 'has a total after hitting' do
        @game.round
        @game.player.total.should eql 16
        @game.dealer.total.should eql 12

      end

      it 'calls stand if the total is 17 or over' do
        sample_deck =[{:value => 7,   :suit => "hearts", :card => "7"},
                      {:value => 10,   :suit => "hearts", :card => "jack"},
                      {:value => 7,   :suit => "hearts", :card => "4"},
                      {:value => 10,   :suit => "hearts", :card => "queen"}]
        @game = Game.new()
        @game.stub(:deck).and_return(sample_deck)
        @game.stub(:shuffle).and_return(sample_deck)
        @game.deal
        @game.player.should_receive(:stand)
        @game.dealer.should_receive(:stand)
        @game.round
      end
    end
  end

  describe "shuffle" do
    it 'shuffles the cards so they are\'t in order' do
      card_deck = Game.new()
      card_deck.shuffle
      card_deck.should_not eql Game.new()
    end
  end
end

