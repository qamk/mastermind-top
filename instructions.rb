# frozen-string-literal: true

# Show instructions using HEREDOC
module Instructions
  def instructions
    puts <<-HEREDOC
    So what is mastermind? In short it's a board-game focused on code-breaking. This means there are two positions:
    1. Code Maker
    2. Code Breaker
    This program allows you to choose between either mode.
    As the \e[1;31mCode Maker\e[0m you will create your own 4-digit code (values from 1 to 6), which the computer will try and guess.
    As the \e[1;34mCode Breaker\e[0m you will try and crack the computer's 4-digit code. 
    In the board game, each code is a coloured peg, hence in this program each digit has its own colour. We have...
    \e[1;38;5;1m 1 \e[0m, \e[1;38;5;27m 2 \e[0m, \e[1;38;5;40m 3 \e[0m, \e[1;38;5;63m 4 \e[0m, \e[1;38;5;87m 5 \e[0m, \e[1;38;5;226m 6 \e[0m
    In order for this to be any fun, you get feedback for each correct digit you guess (or, later, deduce) as part of the code.
    Since order matters, a digit can either be a) correct in position and value or b) correct in value or c) not in the code
    In the case of b, it means that, yay, you have the right digit but in the wrong place.
    In the board game, these are denoted by smaller pins. Likewise here these are represented by coloured circles (like pegs, right?)
    a) => \e[38;5;208m\u25CF\e[0m b) => \e[97m\u25CF\e[0m c) => \e[31mx \e[0m
    Duplicates are currently allowed, e.g. the code 1134 is valid.
    That's pretty much it. The wiki link is included in the README.md title.
    HEREDOC
  end
end
