# frozen_string_literal: true

class RenderForegroundSprites < RenderSystem
  filter Tag(:foreground), Sprite, Position

  def tick(args)
    sprites = entities.map do |entity|
      make_sprite(entity, x_offset(args), y_offset(args))
    end

    args.outputs.sprites << sprites
    args.outputs.sprites << make_sprite(world.player, x_offset(args), y_offset(args))

    if world.debug?
      labels = entities.map do |entity|
        [entity.position.x, entity.position.y, "#{entity.position.x}:#{entity.position.y}"]
      end
      labels << [world.player.position.x, world.player.position.y, "#{world.player.position.x}:#{world.player.position.y}"]
      args.outputs.labels << labels
    end
  end
end
