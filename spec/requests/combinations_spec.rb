# encoding: utf-8
require 'rails_helper'

describe 'Combinations API' do

  describe 'POST /combinations' do

    context 'when happy path conditions are met' do

      before do
        combiner = double('combiner', execute: true, valid?: true, combinations: [])
        allow(Combinatorialist).to receive(:new).and_return(combiner)
      end
    
      it 'returns 200' do
        post '/combinations', { options: [] }
        expect(response.code).to eq('200')
      end

    end

    context 'when all is well' do

      it 'returns combinations' do
        post '/combinations', { options: ['a', 'b'] }
        expect(response.code).to eq('200')
        expect(JSON.parse(response.body)).to eq(['a','b','ab','ba'])
      end

    end

  end

end
