 def generate_grid(grid_size)
    # TODO: generate random grid of letters
    alphabet = ('A'..'Z').to_a
    grid = Array.new(grid_size) { alphabet.sample }
    return grid
  end
  def validate_english(word)
  # Method confirm if the word exists in english
  url = "http://wagon-dictionary.herokuapp.com/#{word}"
  response_serialized = open(url).read
  response = JSON.parse(response_serialized)
  return response
end

def validate_grid(grid, attempt)
  attempt.upcase.split(//).each do |letter|
    if grid.include?(letter)
      grid.slice!(grid.index(letter))
    else
      return false
    end
  end
  return true
end

  def run_game(attempt, grid, start_time, end_time)
    # TODO: runs the game and return detailed hash of result
    exist_in_grid   = validate_grid(grid, attempt)
    is_valid_word   = validate_english(attempt)
    score = exist_in_grid && is_valid_word["found"] ? (is_valid_word["length"]/(end_time - start_time))*is_valid_word["length"] : 0

    if is_valid_word["found"] == false
      message = "Not an english word!"
    elsif is_valid_word["found"] && exist_in_grid
      message = "Well Done!"
    elsif exist_in_grid == false
      message = "Not in the grid!"
    else
      message = "You Lost!"
    end

    result = { time: end_time - start_time, score: score, message: message }
    return result
  end
