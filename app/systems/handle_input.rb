# frozen_string_literal: true

class HandleInput < Draco::System
  filter PlayerControlled, Position

  def tick(args)
    entities.each do |entity|
      unless world.solved?
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

      if args.inputs.keyboard.key_up.escape
        args.state.level = Level1.new
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

    # check if pushable can be moved in direction and move
    pushables.each do |pushable|
      case entity.direction.points_to
      when Direction::LEFT
        pushable.position.move_left if pushable.can_move_left?(level_solids)
      when Direction::RIGHT
        pushable.position.move_right if pushable.can_move_right?(level_solids)
      when Direction::UP
        pushable.position.move_up if pushable.can_move_up?(level_solids)
      when Direction::DOWN
        pushable.position.move_down if pushable.can_move_down?(level_solids)
      end
    end
  end

  def level_solids
    @level_solids ||= world.filter(Collides)
  end

  def level_pushables
    @level_pushables ||= world.filter(Pushable)
  end
end
