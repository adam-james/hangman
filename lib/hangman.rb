# frozen_string_literal: true

# TODO
# - test with rSpec
# - run rubocop
# - get more words (dict file or custom file)
require_relative './lib/dictionary'
require_relative './lib/game'
require_relative './lib/prompter'

# The top-level object for the hangman game.
class Hangman
  def initialize
    @game = Game.new(Dictionary.new.random_word)
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
