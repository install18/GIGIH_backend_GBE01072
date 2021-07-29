# frozen_string_literal: true

require_relative '../src/wli'

RSpec.describe WLI do
  it 'like' do
    # given
    wli = WLI.new

    # when
    wli.names = ['Jacob', 'Alex']

    # then
    expect(wli.likes).to eq('Jacob and Alex like this')
  end

  it 'like' do
    # given
    wli = WLI.new

    # when
    wli.names = ['Max', 'John', 'Mark']

    # then
    expect(wli.likes).to eq('Max, John and Mark like this')
  end

  it 'like' do
    # given
    wli = WLI.new

    # then
    expect(wli.likes).to eq('no one likes this')
  end

  it 'like' do
    # given
    wli = WLI.new

    # when
    wli.names = ['Peter']

    # then
    expect(wli.likes).to eq('Peter likes this')
  end

  it 'like' do
    # given
    wli = WLI.new

    # when
    wli.names = ['Alex', 'Jacob', 'Mark', 'Max']

    # then
    expect(wli.likes).to eq('Alex, Jacob and 2 others like this')
  end
end
