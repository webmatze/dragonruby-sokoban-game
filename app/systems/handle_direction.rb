class HandleDirection < Draco::System
  filter PlayerControlled, Direction, Sprite

  def tick(args)
    entities.each do |entity|
      entity.direction.right if args.inputs.right
      entity.direction.left if args.inputs.left
      entity.direction.up if args.inputs.up
      entity.direction.down if args.inputs.down
      entity.sprite.angle = entity.direction.to_angle
    end
  end
end
