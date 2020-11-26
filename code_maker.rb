# frozen-string-literal: true

require_relative 'mechanics.rb'
require_relative 'pegs.rb'
require_relative 'text_feedback'

# Class for the code-maker mode
class CodeMaker
  include Mechanics
  include Pegs
  include TextFeedback

  attr_reader :best_guess, :player_code, :guess, :previous_shuffles, :turn, :key_pegs, :encoded_guess, :previous_values
  # guess, best_guess, name, key_pegs, encoded_guess and turn must moved to a Game class from both modes
  def initialize(name)
    @name = name
    @best_guess = []
    @key_pegs = []
    @encoded_guess = []
    @turn = 0
    @previous_shuffles = []
    @previous_values = []
    play
  end

  def make_code
    code_maker_message
    @player_code = gets.chomp
    @player_code = valid_code(player_code)
  end

  def make_guess
    @guess = Array.new(4) { rand(1..6) }.join
  end

  def play
    make_code
    make_guess
    outro or return if player_code == 'q'

    puts 'Getting the correct values... bear with me.'
    values_loop
    puts 'OK. Deducing your code...'
    positions_loop
    guess == player_code ? computer_win_msg(true) : player_win_msg(true)
    outro
  end

  def display
    system('sleep 1')
    clear_encoding(key_pegs, encoded_guess)
    process_guess(best_guess, key_pegs, guess, player_code)
    encode_guess(guess, encoded_guess)
    display_feedback(encoded_guess, key_pegs)
  end

  def values_loop
    loop do
      guess_accuracy = process_guess(best_guess, key_pegs, guess, player_code)
      break if guess_accuracy =~ /\D{4}/ || turn > 11 || guess == player_code

      @turn += 1
      current_round(turn)
      until_values(guess_accuracy)
      display
    end
  end

  def positions_loop
    loop do
      guess_accuracy = process_guess(best_guess, key_pegs, guess, player_code)
      break if guess_accuracy =~ /\*{4}/ || turn > 11 || guess == player_code

      @turn += 1
      current_round(turn)
      until_position(guess_accuracy)
      display
    end
  end

  # finds all of the correct values
  def until_values(guess_accuracy)
    guess_accuracy.split('').each_with_index do |ges, i|
      next if ['*', '_'].include?(ges) # ignore correct characters (* OR _)

      loop do
        new_val = rand(1..6).to_s
        unless previous_values.include?(new_val)
          guess[i] = new_val and @previous_values.push(new_val)
          break
        end
      end
    end
  end

  def shuffle_guess(shift_indices, values_to_shift)
    new_shift_values = values_to_shift.shuffle { rand 100 }
    if previous_shuffles.include?(new_shift_values)
      new_shift_values.rotate(1)
      previous_shuffles.push(new_shift_values)
    end
    shift_indices.each_with_index { |shift, i| @guess[shift] = new_shift_values[i] }
  end

  # shifts values until it's all correct
  def until_position(guess_accuracy)
    return if guess_accuracy =~ /\*{4}/

    shift_indices = []
    values_to_shift = []
    guess_accuracy.split('').each_with_index do |acc, i|
      shift_indices.push(i) and values_to_shift.push(guess[i]) if acc == '_'
    end
    shuffle_guess(shift_indices, values_to_shift)
    puts "shifted.... let me check my previous permutations... #{previous_shuffles}" unless previous_shuffles.empty?
  end
end
