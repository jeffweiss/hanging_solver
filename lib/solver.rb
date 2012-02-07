require 'solver/frequency'
require 'solver/reducer'
module Solver
  class Solver
    attr_reader :reducer
    def initialize(filename)
      words = []
      File.open(filename) {|f| f.each_line {|line| words << line.strip } }
      @reducer = Reducer.new words
      puts words.length
    end

    def report(pattern, misses)
      words = @reducer.possibles pattern, misses
      analysis = Frequency.frequency_report words, pattern
      return [analysis, words.first(10)]
    end

    def possible_words(pattern, misses)
      @reducer.possibles pattern, misses
    end
  end
end
