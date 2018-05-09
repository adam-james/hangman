require 'stringio'
require_relative '../lib/hangman/prompter'

TestGame = Struct.new(:answer, :guesses_left, :guessed_right, :guessed_wrong)

describe Prompter do
  before do
    @game = TestGame.new
    @prompter = Prompter.new
  end

  describe '.intro' do
    it 'prints intro message' do
      expect(STDOUT).to receive(:puts).with("Let's play hangman!")
      @prompter.intro
    end
  end

  describe '.already_guessed' do
    it 'prints correct message' do
      msg = 'You already guessed that.'
      expect(STDOUT).to receive(:puts).with(msg)
      @prompter.already_guessed
    end
  end

  describe '.prompt' do
    before do
      $stdin = StringIO.new 't'
      @game.answer = %w[t e s t]
      @game.guesses_left = 3
      @game.guessed_right = ['_'] * 4
      @game.guessed_wrong = []
    end

    after do
      $stdin = STDIN
    end

    it 'prints message' do
      msg = <<-MSG
============================
You have 3 guesses left.
Guessed wrong: 
Guessed right: _ _ _ _
============================
What's your guess?
      MSG
      expect { @prompter.prompt(@game) }.to output(msg).to_stdout
    end

    it 'gets input' do
      expect(@prompter.prompt(@game)).to eql('t')
    end
  end

  describe '.prompt_won' do
    it 'prints message' do
      @game.answer = %w[t e s t]
      msg = <<-MSG
You won!
The answer is "test".
    MSG
      expect { @prompter.prompt_won @game }.to output(msg).to_stdout
    end
  end

  describe '.prompt_lost' do
    it 'prints message' do
      @game.answer = %w[t e s t]
      msg = <<-MSG
You lost!
The answer is "test".
    MSG
      expect { @prompter.prompt_lost @game }.to output(msg).to_stdout
    end
  end
end
