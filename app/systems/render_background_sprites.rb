# frozen_string_literal: true

class RenderBackgroundSprites < RenderSystem
  filter Tag(:background), Sprite, Position

  def tick(args)
    sprites = entities.map do |entity|
      make_sprite(entity, x_offset(args), y_offset(args))
    end

    args.outputs.sprites << sprites
  end
end
