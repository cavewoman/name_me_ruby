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

end
