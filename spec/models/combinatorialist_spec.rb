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

    context 'when there is more than one of the same letter in options' do
      
      it 'returns only the unique combinations' do
        combiner = Combinatorialist.new({options: ['a', 'a', 'a']})
        combinations = ['a', 'aa', 'aaa']
        expect(combiner.execute).to eq(true)
        expect(combiner.combinations).to eq(combinations)
      end

    end

  end

  describe '#only_real_words' do
    
    it 'returns real words from an array' do
      combiner = Combinatorialist.new({options: ['a', 'c', 'r'], real: 'true'})
      combinations = ['a','c', 'r', 'ac', 'ar', 'ca', 'cr', 'ra', 'rc', 'acr', 'arc', 'car', 'cra', 'rac', 'rca']
      expect(combiner.only_real_words).to eq(['a', 'car', 'arc'])
    end

  end

  describe '#real_word?' do
      let(:combiner) { Combinatorialist.new({options: ['a', 'c', 'r'], real: 'true'}) }
  
    it 'returns true for real word' do
      expect(combiner.real_word?('car')).to eq(true)
    end

    it 'returns false for fake word' do
      expect(combiner.real_word?('sdfglj')).to eq(false)
    end

  end

end
