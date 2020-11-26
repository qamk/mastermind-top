# frozen-string-literal: true

require_relative 'code_breaker.rb'
require_relative 'code_maker.rb'
require_relative 'instructions.rb'
require_relative 'text_feedback.rb'

# Game class... primarily to include modules.
class Game
  include Instructions
  include TextFeedback
  def initialize
    puts "Welcome to \e[1;31mMastermind\e[0m."
    instructions if show_instructions == 'y'
    play_loop
  end

  def player_name
    puts 'So, what\'s your name?'
    name = gets.chomp
  end

  def show_instructions
    puts 'Enter \'y\' to see instructions. Enter anything else to continue.'
    response = gets.chomp.downcase
  end

  def valid_game_mode?(game_mode)
    %w[1 2].include?(game_mode) ? true : (puts 'Please enter a valid game mode' or false)
  end

  def welcome
    intro
    game_mode = gets.chomp
    loop do
      break if valid_game_mode?(game_mode)

      game_mode = gets.chomp
    end
    game_mode
  end

  def play_mastermind
    game_mode = welcome
    system('clear')
    name = player_name
    case game_mode
    when '1'
      CodeMaker.new(name)
    when '2'
      CodeBreaker.new(name)
    end
  end

  def play_loop
    play_mastermind
    loop do
      puts 'Would you like to play again? If so, enter \'y\'. Anything else ends the game.'
      again = gets.chomp.downcase
      again == 'y' ? play_mastermind : break
    end
  end
end

Game.new
