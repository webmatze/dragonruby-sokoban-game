# frozen_string_literal: true

class NewBox < Moveable
  component Tag(:foreground)
  component Position, x: 0, y: 0
  component Sprite, path: 'sprites/sokuban_0.png'
  component Pushable
end
