require 'open-uri'
require 'json'
require 'wordgame'
class LongestwordController < ApplicationController
  def game
    #rails magic happens. if there is nothing here justsend you to views longestword/game
    # if there is logic it will run it
    # it there something you want to be available in the view, then you need instance variables (@)
    @grid = generate_grid(9)
  end

  def score
    @word = params[:word]
    @start_time = params[:start_time].to_time
    @end_time = Time.now
    @grid = params[:grid].split(//)
    @result = run_game(@word, @grid, @start_time, @end_time)
  end
end
