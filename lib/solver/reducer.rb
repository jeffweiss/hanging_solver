module Solver
  class Reducer
    attr_accessor :words, :misses, :clue
    def initialize(words = [])
      self.words = words
      @misses = []
    end
    
    def bad(char)
      @misses << char 
    end
            
    def possibles(clue = @clue, misses = @misses)
      @clue = clue
      @misses = misses
      select_matching select_correct_length
    end
    
    def select_correct_length(words = @words)
      words.select {|w| w.length == @clue.length}
    end
    
    def last_vowel
      @clue[index_of_last_clue_vowel]
    end
    
    def index_of_last_clue_vowel
      @clue.rindex vowel_regexp
    end
    
    def clue_regex
      working = ""
      @clue.length.times { |x| working << regexp_by_position(x) }
      /^#{working}$/
    end
    
    def regexp_by_position(index)
      if @clue[index] == '.'
        excludes_by_position index
      else
        @clue[index]
      end
    end
    
    def excludes_by_position(index)
      excludes = ""

      excludes << hits
      excludes << misses_as_str
      excludes << vowel if index > index_of_last_clue_vowel
      "[^#{excludes}]"
    end
    
    def hits
      @clue.gsub('.', '')
    end
    
    def misses_as_str
      @misses.join
    end
    
    def vowel
      "aeiou"
    end
    
    def vowel_regexp
      /[#{vowel}]/
    end
    
    def select_matching(words = @words)
      words.select {|w| w =~ clue_regex}
    end
  end
end