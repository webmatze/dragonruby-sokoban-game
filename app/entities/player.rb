# frozen_string_literal: true

class NewPlayer < Draco::Entity
  component Size, width: 64, height: 64
  component Position, x: 500, y: 100
  component Direction, points_to: Direction::DOWN
  component Sprite, path: 'sprites/Blocks/blobLeft.png'
  component PlayerControlled


  def can_move_right?(solids, amount = 1)
    solids.none? do |solid|
      make_rect(solid).intersect_rect?(make_rect(self).merge(x: position.x + amount))
    end
  end

  def can_move_left?(solids, amount = 1)
    solids.none? do |solid|
      make_rect(solid).intersect_rect?(make_rect(self).merge(x: position.x - amount))
    end
  end

  def can_move_up?(solids, amount = 1)
    solids.none? do |solid|
      make_rect(solid).intersect_rect?(make_rect(self).merge(y: position.y + amount))
    end
  end

  def can_move_down?(solids, amount = 1)
    solids.none? do |solid|
      make_rect(solid).intersect_rect?(make_rect(self).merge(y: position.y - amount))
    end
  end

  private

  def make_rect(entity)
    { x: entity.position.x, y: entity.position.y, w: entity.size.width, h: entity.size.height }
  end
end
