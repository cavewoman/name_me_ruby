# encoding: utf-8
require 'rails_helper'

describe 'Combinations API' do

  describe 'GET /combinations' do

    context 'when happy path conditions are met' do

      before do
        combiner = double('combiner', execute: true, valid?: true, combinations: [])
        allow(Combinatorialist).to receive(:new).and_return(combiner)
      end
    
      it 'returns 200' do
        get '/combinations', { options: [] }
        expect(response.code).to eq('200')
      end

    end

    context 'when all combinations are requested' do

      it 'returns combinations' do
        get '/combinations', { options: ['a', 'b'] }
        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)).to eq(['a','b','ab','ba'])
      end

    end

    context 'when only real words are requested' do
      
      it 'returns combinations that create real words' do
        get '/combinations', { options: ['a', 'c', 'r'], real: 'true' }
        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)).to eq(['a', 'car'])
      end

    end

  end

end
