# frozen_string_literal: true

# Gets a word for the game.
class Dictionary
  def initialize
    @words = %w[cat jazz house dog fan]
  end

  def random_word
    @words.sample
  end
end
