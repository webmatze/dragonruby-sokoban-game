# frozen_string_literal: true

class Direction < Draco::Component
  UP = :up
  DOWN = :down
  LEFT = :left
  RIGHT = :right

  attribute :points_to, default: DOWN

  def up
    @points_to = UP
  end

  def down
    @points_to = DOWN
  end

  def left
    @points_to = LEFT
  end

  def right
    @points_to = RIGHT
  end

  def to_angle
    case @points_to
    when Direction::LEFT then 0
    when Direction::RIGHT then 180
    when Direction::UP then 270
    when Direction::DOWN then 90
    else
      0
    end
  end
end
