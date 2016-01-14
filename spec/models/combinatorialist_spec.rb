# encoding: utf-8
require 'rails_helper'

describe Combinatorialist do

  it 'works with valid input' do
    expect(Combinatorialist.new({options: ['a', 'b']})).to be_valid
    expect(Combinatorialist.new({})).not_to be_valid
  end

  it 'requires options to not be empty' do
    expect(Combinatorialist.new({options: []})).not_to be_valid
  end

  describe '#execute' do
    
    it 'returns combinations' do
      combiner = Combinatorialist.new({options: ['a', 'b', 'c']})
      combinations = ["a", "b", "c", "ab", "ac", "ba", "bc", "ca", "cb", "abc", "acb", "bac", "bca", "cab", "cba"]
      expect(combiner.execute).to eq(true)
      expect(combiner.combinations).to eql(combinations)
    end

  end

end
