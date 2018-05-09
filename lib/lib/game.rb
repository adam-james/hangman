# frozen_string_literal: true

# Tracks game state.
class Game
  attr_reader :answer, :guesses_left, :guessed_right, :guessed_wrong

  def initialize(word)
    @answer = word.split('')
    @guesses_left = 3
    @guessed_right = ['_'] * answer.size
    @guessed_wrong = []
  end

  def check_guess(guess)
    indexes = find_indexes(guess)
    if indexes.empty?
      handle_wrong(guess)
    else
      handle_right(guess, indexes)
    end
  end

  def already_guessed?(guess)
    guessed_wrong.include?(guess) || guessed_right.include?(guess)
  end

  def lost?
    @guesses_left < 1
  end

  def over?
    won? || lost?
  end

  def won?
    !@guessed_right.include?('_')
  end

  private

  def handle_wrong(guess)
    @guessed_wrong.push(guess)
    @guesses_left -= 1
  end

  def handle_right(guess, indexes)
    indexes.each do |index|
      @guessed_right[index] = guess
    end
  end

  def find_indexes(guess)
    letters_and_indexes =
      @answer.each_with_index.select do |letter, _index|
        letter == guess
      end
    letters_and_indexes.map { |_letter, index| index }
  end
end
