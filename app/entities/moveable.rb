# frozen_string_literal: true

class Moveable < Draco::Entity
  def can_move_right?(entities, amount = 1)
    rects = entities.map(&method(:make_rect))
    self_rect = make_rect(self)
    rects.none? do |rect|
      rect.intersect_rect?(self_rect.merge(x: position.x + amount))
    end
  end

  def can_move_left?(entities, amount = 1)
    rects = entities.map(&method(:make_rect))
    self_rect = make_rect(self)
    rects.none? do |rect|
      rect.intersect_rect?(self_rect.merge(x: position.x - amount))
    end
  end

  def can_move_up?(entities, amount = 1)
    rects = entities.map(&method(:make_rect))
    self_rect = make_rect(self)
    rects.none? do |rect|
      rect.intersect_rect?(self_rect.merge(y: position.y + amount))
    end
  end

  def can_move_down?(entities, amount = 1)
    rects = entities.map(&method(:make_rect))
    self_rect = make_rect(self)
    rects.none? do |rect|
      rect.intersect_rect?(self_rect.merge(y: position.y - amount))
    end
  end

  private

  def make_rect(entity)
    { x: entity.position.x, y: entity.position.y, w: entity.size.width, h: entity.size.height }
  end
end
