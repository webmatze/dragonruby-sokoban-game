# frozen_string_literal: true

class RenderBackgroundSprites < Draco::System
  filter Tag(:background), Sprite, Position, Size

  def tick(args)
    sprites = entities.map(&method(:make_sprite))

    args.outputs.sprites << sprites
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
