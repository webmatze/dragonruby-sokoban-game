# frozen_string_literal: true

class RenderSystem < Draco::System
  protected

  def x_offset(args)
    @x_offset ||= ((args.grid.w / 2) - (world.level_data.first.size * world.tile_size / 2))
  end

  def y_offset(args)
    @y_offset ||= args.grid.top - world.tile_size - ((args.grid.h / 2) - (world.level_data.size * world.tile_size / 2))
  end

  def make_sprite(entity, x_offset, y_offset)
    x_pos = (entity.position.x * world.tile_size) + x_offset
    y_pos = y_offset - (entity.position.y * world.tile_size)
    {
      x: x_pos,
      y: y_pos,
      w: world.tile_size,
      h: world.tile_size,
      angle: entity.sprite.angle,
      path: entity.sprite.path
    }
  end
end
