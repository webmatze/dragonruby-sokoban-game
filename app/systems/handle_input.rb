# frozen_string_literal: true

class HandleInput < Draco::System
  filter PlayerControlled, Position

  def tick(args)
    entities.each do |entity|
      if args.inputs.keyboard.key_down.right
        move_pushables(entity)
        entity.position.move_right if entity.can_move_right?(level_solids)
      end

      if args.inputs.keyboard.key_down.left
        move_pushables(entity)
        entity.position.move_left if entity.can_move_left?(level_solids)
      end

      if args.inputs.keyboard.key_down.up
        move_pushables(entity)
        entity.position.move_up if entity.can_move_up?(level_solids)
      end

      if args.inputs.keyboard.key_down.down
        move_pushables(entity)
        entity.position.move_down if entity.can_move_down?(level_solids)
      end
    end
  end

  private

  def move_pushables(entity)
    # find future position
    player_pos = entity.position.to_point
    case entity.direction.points_to
    when Direction::LEFT then player_pos[:x] -= 1
    when Direction::RIGHT then player_pos[:x] += 1
    when Direction::UP then player_pos[:y] -= 1
    when Direction::DOWN then player_pos[:y] += 1
    end

    # find pushables in direction
    pushables = level_pushables.select do |pushable|
      player_pos == pushable.position.to_point
    end
    # check if pushable can be moved in direction
    pushables.each do |pushable|
      case entity.direction.points_to
      when Direction::LEFT then pushable.position.move_left
      when Direction::RIGHT then pushable.position.move_right
      when Direction::UP then pushable.position.move_up
      when Direction::DOWN then pushable.position.move_down
      end
    end
    # move in direction
  end

  def level_solids
    @level_solids ||= world.filter(Collides)
  end

  def level_pushables
    @level_pushables ||= world.filter(Pushable)
  end
end
