# frozen_string_literal: true

class Position < Draco::Component
  attribute :x, default: 0
  attribute :y, default: 0

  def move_right(amount = 1)
    @x += amount
  end

  def move_left(amount = 1)
    @x -= amount
  end

  def move_up(amount = 1)
    @y += amount
  end

  def move_down(amount = 1)
    @y -= amount
  end
end
