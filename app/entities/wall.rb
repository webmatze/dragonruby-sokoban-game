# frozen_string_literal: true

class NewWall < Draco::Entity
  component Tag(:background)
  component Position, x: 0, y: 0
  component Sprite, path: 'sprites/sokuban_2.png'
  component Collides
end
