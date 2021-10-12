# frozen_string_literal: true

class NewBox < Moveable
  NORMAL_BOX = 'sprites/sokuban_0.png'.freeze
  ON_TARGET_BOX = 'sprites/sokuban_6.png'.freeze

  component Tag(:foreground)
  component Position, x: 0, y: 0
  component Sprite, path: NORMAL_BOX
  component Collides
  component Pushable
end
