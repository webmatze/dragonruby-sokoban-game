# frozen_string_literal: true

class HandleInput < Draco::System
  filter PlayerControlled, Position

  def tick(args)
    entities.each do |entity|
      if world.solved?
        if args.inputs.keyboard.key_down.space
          load_next_level(args)
        end
      else
        if args.inputs.keyboard.key_down.right
          move_pushables(entity)
          if entity.can_move_right?(level_solids)
            entity.position.move_right
            world.history << :r
          end
        end

        if args.inputs.keyboard.key_down.left
          move_pushables(entity)
          if entity.can_move_left?(level_solids)
            entity.position.move_left
            world.history << :l
          end
        end

        if args.inputs.keyboard.key_down.up
          move_pushables(entity)
          if entity.can_move_up?(level_solids)
            entity.position.move_up
            world.history << :u
          end
        end

        if args.inputs.keyboard.key_down.down
          move_pushables(entity)
          if entity.can_move_down?(level_solids)
            entity.position.move_down
            world.history << :d
          end
        end
      end

      if args.inputs.keyboard.key_up.plus
        world.tile_size += 4 if world.tile_size < 64
      end

      if args.inputs.keyboard.key_up.hyphen
        world.tile_size -= 4 if world.tile_size > 16
      end

      if args.inputs.keyboard.key_up.escape
        load_level(args, args.state.level.current_level)
      end

      if args.inputs.keyboard.key_down.n
        load_next_level(args)
      end

      if args.inputs.keyboard.key_down.d
        world.debug = !world.debug
      end
    end
  end

  def load_next_level(args)
    next_level = args.state.level.current_level + 1
    load_level(args, next_level)
  end

  def load_level(args, level)
    args.state.level.current_level = level
    args.state.level.reset
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
