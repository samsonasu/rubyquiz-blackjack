class RandomStrategy < Strategy
  def action
    if rand > 0.5
      return :hit
    else
      return :stand
    end
  end
end