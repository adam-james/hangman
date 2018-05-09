# frozen_string_literal: true

# Delivers prompts for game.
class Prompter
  def initialize
    @scoreboard = Scoreboard.new
  end

  def intro
    puts "Let's play hangman!"
  end

  def already_guessed
    puts 'You already guessed that.'
  end

  def prompt(game)
    @scoreboard.render(game)
    puts "What's your guess?"
    guess = gets.chomp[0]
    guess
  end

  def prompt_won(game)
    puts 'You won!'
    show_answer(game)
  end

  def prompt_lost(game)
    puts 'You lost!'
    show_answer(game)
  end

  def show_answer(game)
    puts %(The answer is "#{game.answer.join('')}".)
  end

  # Prints the scoreboard.
  class Scoreboard
    def render(game)
      separator
      guesses_left(game)
      guessed_wrong(game)
      guessed_right(game)
      separator
    end

    private

    def guesses_left(game)
      puts "You have #{game.guesses_left} guesses left."
    end

    def guessed_wrong(game)
      puts "Guessed wrong: #{game.guessed_wrong.join(', ')}"
    end

    def guessed_right(game)
      puts "Guessed right: #{game.guessed_right.join(' ')}"
    end

    def separator
      puts '============================'
    end
  end
end
