# frozen_string_literal: true

module Moveable
  def can_move_right?(solids, amount = 1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(dup.tap { |s| s.x += amount })
    end
  end

  def can_move_left?(solids, amount = 1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(dup.tap { |s| s.x -= amount })
    end
  end

  def can_move_up?(solids, amount = 1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(dup.tap { |s| s.y += amount })
    end
  end

  def can_move_down?(solids, amount = 1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(dup.tap { |s| s.y -= amount })
    end
  end

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
