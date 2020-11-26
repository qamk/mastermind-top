# [Mastermind](https://www.wikiwand.com/en/Mastermind_(board_game))
This code is for a mastermind game created using the Ruby Programming language as part of The Odin Project. Links and resources I found useful will be listed at the bottom!

## Aim and Rules
The aim is simple: the **code breaker** must guess the **code maker**'s 4-digit code. The deciding board in this game will allow for twelve guesses. Each part of the code is represented by one of 6 coloured pegs (*code pegs*) in the board game. In other words, a code is a sequence of values.

The code breaker must get both the value and order (of the code) correct. Each time a guess is made, feedback is provided in the form of smaller coloured pegs (*key pegs*), typically black and white. Black represents correct value and position of a guess; white represents correct value only. In our case the key colours will be orange and white.

## Task
Create a Mastermind game that:
- [x] Has 12 rounds
- [x] Provides feedback after each guess
- [x] Allows the player to guess the computer's code
- [x] Allows the computer to guess the player's code
- [x] \(Optional) Provides instructions
- [x] \(Optional) Computer employs a guessing strategy
- [] \(Optional) Allows for a mode without duplicates
- [] \(Optional) Uses a board

## Useful resources
There are a number of things I learnt about from searching "how to do x". Other than the documentation, there were some other places I looked to do things like:
- [Escape characters (under "String")](https://docs.ruby-lang.org/en/2.4.0/syntax/literals_rdoc.html)
  - Especially \u and \e for unicode and colouring command-line output respectively.
- [Colouring output in the command line](https://misc.flogisoft.com/bash/tip_colors_and_formatting)
  - A nice way to represent the pins. These also work with unicode characters. As you can see, \e is represented in ruby as well as other programming languages of course.
- [Comprehensive character references](https://www.fileformat.info/info/unicode/category/index.htm)
  - Nicely ordered. It also shows the different encodings. The \u hex code is the one relevant to Ruby.
  - [Alternative site which is nice to look at](https://www.toptal.com/designers/htmlarrows/)
- [Formatting Github markdown files \(e.g. this README.md)](https://docs.github.com/en/free-pro-team@latest/github/writing-on-github)
  - Just something worth practising for presentation purposes.
