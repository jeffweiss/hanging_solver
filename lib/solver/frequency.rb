module Solver
  class Frequency
    def self.letter_frequencies(words)
      freq = {}
      words.each do |word|
        letters_per_word(word).each do |letter|
          freq[letter] ||= 0
          freq[letter] += 1
        end
      end
      freq
    end
    
    def self.frequency_report(words, clue)
      ary = []
      letter_frequencies(words).each_pair { |k,v| ary << { k=> v} }
      ary.sort { |x,y| y.values[0] <=> x.values[0] }.first(10)
    end

    def self.letters_per_word(word)
      chars = []
      word.each_char do |char| 
        char = char.to_sym
        chars << char unless chars.include? char 
      end
      chars
    end
  end
end
