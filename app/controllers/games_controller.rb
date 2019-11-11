require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @letters = params[:collected_input]
    answer = params[:answer].upcase
    @output = run_game(answer, @letters.split(' '))

    # raise
    # @output = answer
  end

  def run_game(attempt, grid)
    # TODO: runs the game and return detailed hash of result
    result = ""
    if !isingrid?(attempt, grid)
      # result[:score] = 0
      result = "not in the grid"
    elsif !isvalid?(attempt)
      # result[:score] = 0
      result = "not an english word"
    else
      # result[:score] = attempt.length / result[:time]
      result = "well done"
    end
    return result
  end

  def isingrid?(word, grid)
    test = false
    word.split("").each do |letter|
      if grid.include? letter.upcase
        test = true
        grid.delete_at(grid.index(letter.upcase))
      else
        test = false
        break
      end
    end
    return test
  end

  # p isingrid?("train", %w(W G G Z O N A L))

  def isvalid?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word.downcase}"
    output = JSON.parse(open(url).read)
    return output["found"].to_s == "true"
  end
end
