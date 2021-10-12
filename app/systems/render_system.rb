# frozen_string_literal: true

class RenderSystem < Draco::System
  protected

  def x_offset(args)
    @x_offset ||= ((args.grid.w / 2) - (world.level_data.first.size * world.tile_size / 2))
  end

  def y_offset(args)
    @y_offset ||= args.grid.top - world.tile_size - ((args.grid.h / 2) - (world.level_data.size * world.tile_size / 2))
  end

  def tile_x(x, args)
    (x * world.tile_size) + x_offset(args)
  end

  def tile_y(y, args)
    y_offset(args) - (y * world.tile_size)
  end

  def make_sprite(entity, args)
    {
      x: tile_x(entity.position.x, args),
      y: tile_y(entity.position.y, args),
      w: world.tile_size,
      h: world.tile_size,
      angle: entity.sprite.angle,
      path: entity.sprite.path
    }
  end
end
