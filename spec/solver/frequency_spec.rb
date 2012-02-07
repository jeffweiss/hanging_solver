require 'spec_helper'

module Solver
  describe Frequency do
    describe "letter frequencies" do
      before(:each) do
        @words = ["lilly", "silly"]
      end

      it "should not return nil" do
        Frequency.letter_frequencies(@words).should_not be_nil
      end

      it "should return a hash" do
        Frequency.letter_frequencies(@words).is_a?(Hash).should be_true
      end

      it "should count the number of words with that letter" do
        freqs = Frequency.letter_frequencies(@words)
        freqs[:s].should == 1
        freqs[:y].should == 2
      end

      it "should not return a frequency larger than the number of words in the list" do
        freqs = Frequency.letter_frequencies(@words)
        freqs.values.count {|c| c> @words.length}.should == 0
      end
    end
    
    describe "letters per word" do
      before(:each) do
        word = "lilly"
        @letters = Frequency.letters_per_word(word)
      end
      it "should not return nil" do
        @letters.should_not be_nil
      end
      it "should return an array" do
        @letters.is_a?(Array).should be_true
      end
      it "should convert the letter to symbols" do
        @letters.count { |e| e.class == Symbol}.should == @letters.length
      end
      it "should only include repeated letters once" do
        @letters.count { |e| e == :l}.should == 1
      end
    end
    
    describe "report" do
      before(:each) do
        @words = ['lilly', 'silly', 'hilly', 'willy', 'silty', 'wilty', 'ailed', 'riled', 'filed', 'piled']
        @clue = '.i...'
        @report = Frequency.frequency_report(@words, @clue)
      end
      it "should return at most 10 letters" do
        @report.length.should <= 10
      end
      it "should exclude the hits from clue" do
        hits = @clue.gsub('.', '')
        @report.each do |x|
          x.each do |k, v|
            hits.include?(k.to_s).should be_false
          end
        end
      end
      it "should be sorted by frequency descending" do
        last = @words.length
        @report.each do |x|
          x.each do |k,v|
            v.should <= last
            last = v
          end
        end
      end
    end  
  end
end