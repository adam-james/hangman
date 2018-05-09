require_relative '../lib/hangman/game'

describe Game do
  before do
    @word = 'test'
    @game = Game.new(@word)
  end

  describe '.initialize' do
    it 'allows 10 guesses' do
      expect(@game.guesses_left).to equal(10)
    end

    it 'turns answer into an array' do
      expect(@game.answer).to eql(@word.split(''))
    end

    it 'sets guessed_right array' do
      expect(@game.guessed_right).to eql(['_'] * @word.size)
    end

    it 'sets guessed_wrong array' do
      expect(@game.guessed_wrong).to eql([])
    end
  end

  describe '.check_guess' do
    context 'given correct guess' do
      it 'keeps the number of guesses the same' do
        guesses_before = @game.guesses_left
        @game.check_guess 't'
        expect(@game.guesses_left).to eql(guesses_before)
      end

      it 'sets the guessed_right correctly' do
        @game.check_guess 't'
        expect(@game.guessed_right).to eql(%w[t _ _ t])
        expect(@game.guessed_wrong).to eql([])
      end
    end

    context 'given incorrect guess' do
      it 'decrements guesses left' do
        before = @game.guesses_left
        @game.check_guess 'z'
        expect(@game.guesses_left).to eql(before - 1)
      end

      it 'sets guessed_wrong' do
        @game.check_guess 'z'
        expect(@game.guessed_wrong).to eql(['z'])
        expect(@game.guessed_right).to eql(['_'] * @word.size)
      end
    end
  end

  describe '.already_guessed?' do
    it 'returns true for repeat' do
      @game.check_guess 't'
      expect(@game.already_guessed?('t')).to eql(true)
    end

    it 'returns false for new guess' do
      expect(@game.already_guessed?('t')).to eql(false)
      @game.check_guess 't'
      expect(@game.already_guessed?('e')).to eql(false)
    end
  end

  describe '.over?' do
    it 'returns false when playing' do
      expect(@game.over?).to eql(false)
      @game.check_guess 't'
      expect(@game.over?).to eql(false)
    end

    context '.won?' do
      it 'returns true' do
        %w[t e s t].each do |letter|
          @game.check_guess(letter)
        end
        expect(@game.won?).to eql(true)
        expect(@game.over?).to eql(true)
      end
    end

    context '.lost?' do
      it 'returns true' do
        %w[z a b c d w q p m n].each do |letter|
          @game.check_guess(letter)
        end
        expect(@game.lost?).to eql(true)
        expect(@game.over?).to eql(true)
      end
    end
  end
end
