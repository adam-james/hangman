# frozen_string_literal: true

require_relative './hangman/dictionary'
require_relative './hangman/game'
require_relative './hangman/prompter'

# The top-level object for the hangman game.
class Hangman
  def initialize
    filepath = ARGV[0] || '/usr/share/dict/words'
    word = Dictionary.from_file(filepath).random_word
    @game = Game.new(word)
    @prompter = Prompter.new
  end

  def play
    start_game
    play_game
    end_game
  end

  private

  def start_game
    @prompter.intro
  end

  def play_game
    until @game.over?
      guess = @prompter.prompt(@game)
      if @game.already_guessed?(guess)
        @prompter.already_guessed
      else
        @game.check_guess(guess)
      end
    end
  end

  def end_game
    if @game.won?
      @prompter.prompt_won(@game)
    else
      @prompter.prompt_lost(@game)
    end
  end
end
