# frozen-string-literal: true

require_relative 'text_feedback.rb'
require_relative 'pegs.rb'

require 'pry'

# Class for human code breaker
class CodeBreaker
  include TextFeedback
  include Pegs

  attr_reader :name, :turn, :code, :computer_code, :key_pegs, :guess, :best_guess, :encoded_guess
  def initialize(name)
    @name = name
    @computer_code = Array.new(4) { rand(1..6) }.join
    @key_pegs = []
    @best_guess = []
    @encoded_guess = []
    @turn = 0
    play_breaker
  end

  def play_breaker
    loop do
      @turn += 1
      puts "\e[95m Round: #{turn} \e[0m"
      guess_feedback
      key_pegs.clear
      encoded_guess.clear
      break if turn > 12 || guess == computer_code
    end
    results
    outro
  end

  def guess_feedback
    prompt
    puts computer_code
    @guess = gets.chomp
    valid_code
    return quit? if guess.downcase == 'q'

    process_guess(guess)
    encode_guess
    display_feedback
  end

  def process_guess(guess)
    temp_computer_code = computer_code.clone # Normal assignment fails here as they then point to the same location
    guess_clone = guess.clone
    iterate_guess(guess_clone, temp_computer_code, 'correct_position?')
    iterate_guess(guess_clone, temp_computer_code, 'correct_value?')
  end

  def iterate_guess(guess_clone, temp_computer_code, method)
    guess_clone.split('').each_with_index do |ges, i|
      puts "latest guess_clone... #{guess_clone}"
      begin
        good_guess = send(method, ges, guess_clone, temp_computer_code, i)
      rescue StandardError
        good_guess = send(method, ges, temp_computer_code, i)
      end
      next unless good_guess

      @best_guess[i, 1] = ges
    end
  end

  def encode_guess
    guess.each_char { |ges| @encoded_guess << (code_peg(ges)) }
  end

  private

  def quit?
    @turn = 13
  end

  def correct_position?(ges, guess_clone, temp_computer_code, pos)
    # binding.pry
    computer_code[pos] == ges ? (@key_pegs << key_peg('p')) : (@key_pegs << 0 and (return false))
    temp_computer_code[pos] = '*'
    guess_clone[pos] = '*' # if you don't "remove" it iterate_guess produces inaccurate results
    true
  end

  def correct_value?(ges, temp_computer_code, pos)
    puts "latest temp_c_c... #{temp_computer_code}"
    # binding.pry
    return false if ges == '*' # else feedback is wrong (too many 'x')

    if temp_computer_code.include?(ges)
      temp_computer_code[temp_computer_code.index(ges)] = '_'
      @key_pegs[pos] = key_peg('v')
    else
      @key_pegs[pos] = key_peg('x')
      return false
    end
    true
  end

  def display_feedback
    display_pegs(encoded_guess)
    display_pegs(key_pegs)
    puts
  end

  def valid_code
    loop do
      break if (guess.length == 4 && guess =~ /[1-6]{4}/) || guess == 'q'

      invalid_guess
      @guess = gets.chomp
    end
  end

  def results
    return if guess == computer_code || turn < 1 || best_guess.empty?

    puts "#{name}, your best guess was #{best_guess}. The code was #{computer_code}.\nYou'll crack it next time!"
  end
end

CodeBreaker.new('qam')
