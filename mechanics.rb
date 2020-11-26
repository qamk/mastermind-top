# frozen-string-literal: true

require 'pry'

# Describes the behaviours mutual to the code_breaker and code_maker modes
module Mechanics
  def process_guess(best_guess, key_pegs, guess, maker_code)
    maker_code_clone = maker_code.clone # Normal assignment fails here as they then point to the same location
    guess_clone = guess.clone
    iterate_guess(best_guess, key_pegs, guess_clone, maker_code_clone, 'correct_position?')
    iterate_guess(best_guess, key_pegs, guess_clone, maker_code_clone, 'correct_value?')
    guess_clone
  end

  def iterate_guess(best_guess, key_pegs, guess_clone, maker_code_clone, method)
    guess_clone.split('').each_with_index do |ges, i|
      # puts "latest guess_clone... #{guess_clone}"
      begin
        good_guess = send(method, key_pegs, ges, guess_clone, maker_code_clone, i)
      rescue StandardError
        good_guess = send(method, key_pegs, ges, guess_clone, maker_code_clone, i)
      end
      next unless good_guess

      best_guess[i, 1] = ges
    end
  end

  def correct_position?(key_pegs, ges, guess_clone, maker_code_clone, pos)
    # binding.pry
    maker_code_clone[pos] == ges ? (key_pegs << key_peg('p')) : (key_pegs << 0 and (return false))
    maker_code_clone[pos] = '*'
    guess_clone[pos] = '*' # if you don't "remove" it iterate_guess produces inaccurate results
    true
  end

  def correct_value?(key_pegs, ges, guess_clone, maker_code_clone, pos)
    return false if ges == '*' # else feedback is wrong (too many 'x')

    if maker_code_clone.include?(ges)
      maker_code_clone[maker_code_clone.index(ges)] = '_'
      guess_clone[pos] = '_'
      key_pegs[pos] = key_peg('v')
    else
      key_pegs[pos] = key_peg('x')
      return false
    end
    true
  end

  def valid_code(guess)
    loop do
      break if (guess.length == 4 && guess =~ /[1-6]{4}/) || guess == 'q'

      invalid_guess
      guess = gets.chomp
    end
    guess
  end

  def quit?
    13
  end

  def clear_encoding(key_pegs, encoded_guess)
    key_pegs.clear
    encoded_guess.clear
  end

  def results(name, guess, maker_code, best_guess)
    return if guess == maker_code || turn < 1 || best_guess.empty?

    puts "#{name}, your best guess contained #{best_guess}. The code was #{maker_code}.\nYou'll crack it next time!"
  end
end
