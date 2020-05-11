require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }.join.upcase.chars   
  end
  
  def is_included?(input, random)
    input.chars.all? { |letter| input.count(letter) <= random.count(letter) }
  end
  
  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}").read
    @result = JSON.parse(url)
    @result["found"]
  end
  
  
  def score
    @user_input = (params["user-word"]).upcase
    letters = params["letters"].split
    
    if is_included?(@user_input, letters)
      # raise
      if english_word?(@user_input)
        @score = @user_input.length
        @message = "Congratulations! #{params["user-word"]} is a valid english word!" 
      else
        @message = "Sorry but #{params["user-word"]} does not seem to be an english word..."
      end
    else
      @message = "Sorry but #{params["user-word"]} can't be bult out of #{letters}"
    end
  end
  
end
