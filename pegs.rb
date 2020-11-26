# frozen-string-literal: true

# Module to represent code and key peg feedback
module Pegs
  def code_peg(code)
    code_hash = {
      '1' => "\e[1;38;5;1m 1 \e[0m",
      '2' => "\e[1;38;5;27m 2 \e[0m",
      '3' => "\e[1;38;5;40m 3 \e[0m",
      '4' => "\e[1;38;5;63m 4 \e[0m",
      '5' => "\e[1;38;5;87m 5 \e[0m",
      '6' => "\e[1;38;5;226m 6 \e[0m"
    }[code]
  end

  def key_peg(key)
    key_hash = {
      'v' => "\e[97m\u25CF\e[0m ",
      'p' => "\e[38;5;208m\u25CF\e[0m ",
      'x' => "\e[31mx \e[0m"
    }[key]
  end

  def encode_guess(guess, encoded_guess)
    guess.each_char { |ges| encoded_guess << (code_peg(ges)) }
  end

  def display_feedback(encoded_guess, key_pegs)
    display_pegs(encoded_guess)
    display_pegs(key_pegs)
    puts
  end

  def display_pegs(pegs)
    pegs = pegs.join if pegs.class == Array
    pegs.each_char { |peg| print peg }
  end
end
