require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = []
    8.times do
      @letters << ("a".."z").to_a.sample
    end
  end

  def score
    @array = params['key'].split(' ')
    @array_r = params['key'].split(' ')
    @answer = params['answer']
    @error_array = true
    @answer.split('').each do |letter|
      if @array_r.include?(letter)
        index = @array_r.find_index(letter)
        @array_r.delete_at(index)
      else
        @error_array = false
      end
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    if !user['found']
      @word = "not a real word"
      @error_word = false
    else
      @error_word = true
    end
    if @error_array && @error_word
      @display_message = "Congratulations!"
      @score = answer.length
    elsif !@error_array
      @display_message = "You used letters not included in the array"
      @score = 0
    elsif @error_array && !@error_word
      @display_message = "This is not an English word"
      @score = 0
    else
      @display_message ="Nothing is good here ... looser"
      @score = 0
    end
  end

end
