# frozen_string_literal: true

# Gets a word for the game.
class Dictionary
  def self.from_file(filepath)
    words = File.readlines(filepath)
    new(words)
  end

  def initialize(words)
    @words = words
  end

  def random_word
    @words.sample.downcase.rstrip
  end
end
