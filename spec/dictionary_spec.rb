require_relative '../lib/hangman/dictionary'

here = File.dirname(File.expand_path(__FILE__))
test_filepath = "#{here}/test_words"
test_words = File.readlines(test_filepath).map { |word| word.rstrip }

describe Dictionary do
  describe '.random_word' do
    context 'words array' do
      it 'returns a random word' do
        dict = Dictionary.new(test_words)
        word = dict.random_word
        expect(test_words.include?(word)).to eql(true)
      end
    end

    context 'from_file' do
      it 'returns a random word' do
        dict = Dictionary.from_file(test_filepath)
        word = dict.random_word
        expect(test_words.include?(word)).to eql(true)        
      end
    end
  end
end