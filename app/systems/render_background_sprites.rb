# frozen_string_literal: true

class RenderBackgroundSprites < RenderSystem
  filter Tag(:background), Sprite, Position

  def tick(args)
    # render background tiles
    args.outputs.sprites << background_tiles.map do |entity|
      make_sprite(entity, args)
    end
    # render Storage tiles
    args.outputs.sprites << storage_tiles.map do |entity|
      make_sprite(entity, args)
    end
  end

  private

  def storage_tiles
    entities.select { |entity| entity.is_a?(NewStorage) }
  end

  def background_tiles
    entities.reject { |entity| entity.is_a?(NewStorage) }
  end
end
