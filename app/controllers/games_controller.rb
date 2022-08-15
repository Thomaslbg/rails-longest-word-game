require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do |i|
      @letters << ("a".."z").to_a.sample
    end
  end

  def score
    @user_word = params[:input]
    @letters = params[:letters]
    @valid = word_valid?(@letters, @user_word)
    @word_length = @user_word.length
    session[:score] = 0 if session[:score].nil?
    if letters_included?(@letters, @user_word) && word_exist?(@user_word)
      @result = "Congratulations! #{@user_word.upcase} is a valid english word!"
      session[:score] += @user_word.length
      @score = session[:score]
    elsif letters_included?(@letters, @user_word)
      @result = "Sorry but #{@user_word.upcase} does not seem to be an english word..."
    else
      @result = "Sorry but #{@user_word.upcase} can't be build out of #{@letters}"
    end
  end

  def letters_included?(letters, user_word)
    user_word.chars.each do |l|
      if letters.include?(l)
        letters.delete(l)
      else
        return false
      end
    end
    return true
  end

  def word_exist?(user_word)
    url = "https://wagon-dictionary.herokuapp.com/#{user_word}"
    serialized_dictionnary = URI.open(url).read
    return JSON.parse(serialized_dictionnary)["found"]
  end

  def word_valid?(letters, user_word)
    letters_included?(letters, user_word) && word_exist?(user_word)
  end
end
