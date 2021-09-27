# frozen_string_literal: true

class Moveable < Draco::Entity
  def can_move_right?(entities, amount = 1)
    self_pos = position.to_point
    entities.none? do |entity|
      entity.position.to_point == self_pos.merge(x: position.x + amount)
    end
  end

  def can_move_left?(entities, amount = 1)
    self_pos = position.to_point
    entities.none? do |entity|
      entity.position.to_point == self_pos.merge(x: position.x - amount)
    end
  end

  def can_move_up?(entities, amount = 1)
    self_pos = position.to_point
    entities.none? do |entity|
      entity.position.to_point == self_pos.merge(y: position.y - amount)
    end
  end

  def can_move_down?(entities, amount = 1)
    self_pos = position.to_point
    entities.none? do |entity|
      entity.position.to_point == self_pos.merge(y: position.y + amount)
    end
  end
end
