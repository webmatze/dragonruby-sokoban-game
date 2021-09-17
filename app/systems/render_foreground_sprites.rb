# frozen_string_literal: true

class RenderForegroundSprites < Draco::System
  filter Tag(:foreground), Sprite, Position, Size

  def tick(args)
    sprites = entities.map(&method(:make_sprite))

    args.outputs.sprites << sprites
    args.outputs.sprites << make_sprite(world.player)
  end

  private

  def make_sprite(entity)
    {
      x: entity.position.x,
      y: entity.position.y,
      w: entity.size.width,
      h: entity.size.height,
      angle: entity.sprite.angle,
      path: entity.sprite.path
    }
  end
end
