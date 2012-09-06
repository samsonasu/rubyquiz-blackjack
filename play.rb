require './black_jack'


#bring in all the strategies
GAME_COUNT = (ARGV[0] || 10).to_i #number of games to simulate

win_count = 0
push_count = 0
played_count = 0
print_stats = Proc.new do
  puts "\t Games played:\t #{played_count}"
  puts "\t Games won:\t #{win_count}"
  puts "\t Win rate:\t #{(win_count.to_f/played_count.to_f)*100}%"
end

game = Game.new

if GAME_COUNT >= 100
  #script really slows down with a lot of iterations due to all the logging
  puts ""
  game.silent = true
end

if (ARGV[1])
  strat = Kernel.const_get(ARGV[1]).new(game)
  game.player.strategy = strat
  puts "Using strategy: #{strat.class.name}"
end

GAME_COUNT.times do 
  played_count += 1
  puts "** New game! **" unless game.silent?
  game.deal
  winner = game.play
  loser = nil
  if (winner.nil?) 
    push_count += 1
    puts "Push!" unless game.silent?
    next
  elsif (winner.kind_of? Player)
    win_count += 1
    loser = game.dealer
  else
    loser = game.player
  end
  puts "#{winner.name} Wins #{winner.total} to #{loser.total}" unless game.silent?
  if (game.silent? && (played_count % (GAME_COUNT/4) == 0) )
    puts "========"
    print_stats.call
  end
end

puts "====== Done! ======"
print_stats.call