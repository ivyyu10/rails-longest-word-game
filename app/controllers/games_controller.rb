require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
    @letters << ('A'..'Z').to_a.sample
    end
    @letters
  end

  def score
    @letters = params[:letters]
    @word = params[:input].upcase

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    check = open(url).read
    word_check = JSON.parse(check)
    in_grid = @word.split.all? { |letter| @word.count(letter) <= @letters.count(letter) }

    if in_grid == false
      @message = "Sorry but #{@word} cannot be built out of #{@letters}"
    elsif word_check["found"] == false
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{@word} is a valid English word."
    end
  end

end
