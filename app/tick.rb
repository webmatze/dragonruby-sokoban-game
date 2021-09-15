# frozen_string_literal: true

$gtk.reset

$game = Game.new

def tick(args)
  $game.args = args
  $game.tick
end
