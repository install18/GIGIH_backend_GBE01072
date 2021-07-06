# frozen_string_literal: true

require_relative 'player'

jin = Player.new('Jin Sakai', 100, 50)
puts jin

khotun = Player.new('Khotun Khan', 500, 50)
puts khotun

while 1
  khotun.attack(jin)
  if jin.is_dead?
    break
  end

  jin.attack(khotun)
  if khotun.is_dead?
    break
  end
end