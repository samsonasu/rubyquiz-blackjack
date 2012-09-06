require './black_jack'
require './person'


describe "Person" do

  describe "Card management" do
    before(:each) do 
      @person = Person.new
      @person.cards = [
        Deck::Card[:value => 2,   :suit => "hearts", :card => "2"], 
        Deck::Card[:value => 3,   :suit => "hearts", :card => "3"], 
        Deck::Card[:value => 4,   :suit => "hearts", :card => "4"], 
        Deck::Card[:value => 5,   :suit => "hearts", :card => "5"]
      ] 
    end
    it 'can sum its cards' do
      @person.total.should eql 14 
    end

    it 'can detect black jack' do
      @person.blackjack?.should be_false #only 14
      @person.cards = [
        Deck::Card[:value => 11, :suit => :hearts, :card => "ace"],
        Deck::Card[:value => 10, :suit => :hearts, :card => "king"]
      ]
      @person.blackjack?.should be_true
    end

    it 'knows if it has busted' do
      @person.busted?.should be_false
      @person.cards << Deck::Card[:value => 10, :suit => :hearts, :card => "king"]
      @person.busted?.should be_true
    end

    it "won't bust with a soft ace" do 
      @person.cards << Deck::Card[:value => 11, :suit => :hearts, :card => "ace"]
      @person.busted?.should be_false
      @person.total.should eql 15
    end
  end
end