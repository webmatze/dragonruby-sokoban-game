# frozen_string_literal: true

class NewPlayer < Moveable
  component Size, width: 64, height: 64
  component Position, x: 500, y: 100
  component Direction, points_to: Direction::DOWN
  component Sprite, path: 'sprites/sokuban_5.png'
  component PlayerControlled
end
