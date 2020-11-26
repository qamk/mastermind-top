# frozen-string-literal: true

require_relative 'text_feedback.rb'
require_relative 'pegs.rb'
require_relative 'mechanics.rb'

# Class for human code breaker
class CodeBreaker
  include TextFeedback
  include Pegs
  include Mechanics

  attr_reader :name, :turn, :code, :computer_code, :key_pegs, :guess, :best_guess, :encoded_guess
  def initialize(name)
    @name = name
    @computer_code = Array.new(4) { rand(1..6) }.join
    @key_pegs = []
    @best_guess = []
    @encoded_guess = []
    @turn = 0
    code_breaker_message
    play_breaker
  end

  # Use as part of the game
  def play_breaker
    loop do
      @turn += 1
      current_round(turn)
      guess_feedback
      clear_encoding(key_pegs, encoded_guess)
      break if turn > 12 || guess == computer_code
    end
    results(name, guess, computer_code, best_guess)
    outro
  end

  def guess_feedback
    prompt
    @guess = gets.chomp
    @guess = valid_code(guess)
    return @turn = quit? if guess.downcase == 'q'

    process_guess(best_guess, key_pegs, guess, computer_code)
    display
  end

  def display
    encode_guess(guess, encoded_guess)
    display_feedback(encoded_guess, key_pegs)
  end
end
