class HandleInput < Draco::System
  filter PlayerControlled, Position

  def tick(args)
    level_solids = world.filter(Collides)
    entities.each do |entity|
      amount = 4
      if args.inputs.right
        # player.look_right
        entity.position.move_right(amount) if entity.can_move_right?(level_solids, amount)
      end

      if args.inputs.left
        # player.look_left
        entity.position.move_left(amount) if entity.can_move_left?(level_solids, amount)
      end

      if args.inputs.up
        # player.look_up
        entity.position.move_up(amount) if entity.can_move_up?(level_solids, amount)
      end

      if args.inputs.down
        # player.look_down
        entity.position.move_down(amount) if entity.can_move_down?(level_solids, amount)
      end
    end
  end
end
