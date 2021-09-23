# frozen_string_literal: true

class HandleInput < Draco::System
  filter PlayerControlled, Position

  def tick(args)
    entities.each do |entity|
      amount = 64

      if args.inputs.keyboard.key_down.right
        entity.position.move_right(amount) if entity.can_move_right?(level_solids, amount)
      end

      if args.inputs.keyboard.key_down.left
        entity.position.move_left(amount) if entity.can_move_left?(level_solids, amount)
      end

      if args.inputs.keyboard.key_down.up
        entity.position.move_up(amount) if entity.can_move_up?(level_solids, amount)
      end

      if args.inputs.keyboard.key_down.down
        entity.position.move_down(amount) if entity.can_move_down?(level_solids, amount)
      end
    end
  end

  private

  def level_solids
    @level_solids ||= world.filter(Collides)
  end

  def level_pushables
    @level_pushables ||= world.filter(Pushable)
  end
end
