# frozen-string-literal: true

# Module for displaying feedback to the user
module TextFeedback
  def prompt
    puts 'Please enter your guess as a sequence of four numbers (e.g.1234) between 1 and 6 or q to quit.'
  end

  def code_maker_message
    puts 'Welcome to the code maker mode. Here, you will create a code that the computer will try and break.'
    prompt
  end

  def code_breaker_message
    puts 'Welcome to the code breaker mode. Here, the computer will create a code, and you will try and break it.'
    prompt
  end

  def invalid_guess
    puts 'That guess is invalid.'
    prompt
  end

  def player_win_msg(computer_guesser = nil)
    puts 'Congratulations! Your guess is spot on.' or return unless computer_guesser

    puts 'Congratulations! Your code was too tough for the computer to handle. Your secrets are safe. For now...'
  end

  def computer_win_msg(computer_guesser = nil)
    puts 'Pfft. All in a moment\'s work for me.' or return if computer_guesser

    puts 'Unfortunately the you have failed to guess the computer\'s code. The vault remains secure. For now...'
  end

  def current_round(turn)
    puts "\e[95m Round: #{turn} \e[0m"
  end

  def intro
    puts <<~HEREDOC
    You have two modes to play vs the computer:
    1. \e[1;31mCode Maker\e[0m
    2. \e[1;34mCode Breaker\e[0m
    To play just type the number of the mode above.
    HEREDOC
  end

  def outro
    puts 'I hope you\'ve enjoyed this game of Mastermind. Please let me know if you have any suggestions.'
  end
end
