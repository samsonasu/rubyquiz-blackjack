#this is a naive strategy that should not be used in a casino
class Strategy
    def initialize(game)
        @player = game.player
    end

    #return a number between 0 and 1 that represents the position of the cut
    def cut_position
        0 #no cut
    end

    def action
        if @player.total > 17
            :stand
        else
            :hit
        end
    end
end