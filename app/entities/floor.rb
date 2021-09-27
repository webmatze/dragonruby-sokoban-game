# frozen_string_literal: true

class NewFloor < Draco::Entity
  component Tag(:background)
  component Position, x: 0, y: 0
  component Sprite, path: 'sprites/sokuban_1.png'
end
