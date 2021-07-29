# frozen_string_literal: true

require_relative '../src/incremental'

RSpec.describe Incremental do
  it 'returns [5,6,2] if passed [5,6,1]' do
    array_of_integer = Incremental.new

    result = array_of_integer.increment([5, 6, 1])

    expect(result).to eq([5, 6, 2])
  end
end
