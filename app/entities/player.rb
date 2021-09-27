# frozen_string_literal: true

class NewPlayer < Moveable
  component Position, x: 0, y: 0
  component Direction, points_to: Direction::DOWN
  component Sprite, path: 'sprites/sokuban_5.png'
  component PlayerControlled
end
