require 'spec_helper'

module Solver
  describe Reducer do
    before(:each) do
      @words = ["live", "love", "clove", "lord", "sword", "mirth", "story", "stops"]
      @r = Reducer.new @words 
      @r.clue = "..o.."
      @r.bad "w"
    end
    it "should load words" do
      @r.words.length.should >= 1
    end
    it "should reduce the possibles based on clue length" do
      possibles = @r.possibles
      possibles.count {|w| w.length == @r.clue.length}.should == possibles.length
    end
    it "should not include words that don't match clue" do
      @r.possibles.include?("mirth").should be_false
    end
    it "should not include words with vowels after clues's last vowel" do
      @r.possibles.include?("clove").should be_false
    end
    it "should reduce possibles based on clue's hits" do
      clue = "s.o.."
      possibles = @r.possibles clue
      possibles.include?("mirth").should be_false
    end
    it "should not include words that have hits in other locations" do
      clue = "s.o.."
      @r.possibles(clue).include?("stops").should be_false
    end      
    it "should not include words that contain misses" do
      @r.possibles.include?("sword").should be_false
    end
  end
end