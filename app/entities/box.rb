# frozen_string_literal: true

class NewBox < Moveable
  component Tag(:foreground)
  component Size, width: 64, height: 64
  component Position, x: 0, y: 0
  component Sprite, path: 'sprites/sokuban_0.png'
  component Pushable
end
