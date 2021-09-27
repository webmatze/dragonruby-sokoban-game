class HandleDirection < Draco::System
  filter PlayerControlled, Direction, Sprite

  def tick(args)
    entities.each do |entity|
      entity.direction.right if args.inputs.keyboard.key_down.right
      entity.direction.left if args.inputs.keyboard.key_down.left
      entity.direction.up if args.inputs.keyboard.key_down.up
      entity.direction.down if args.inputs.keyboard.key_down.down
      entity.sprite.angle = entity.direction.to_angle
    end
  end
end
