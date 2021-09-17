# frozen_string_literal: true

class NewStorage < Draco::Entity
  component Tag(:foreground)
  component Size, width: 64, height: 64
  component Position, x: 0, y: 0
  component Sprite, path: 'sprites/Blocks/heart.png'
end
