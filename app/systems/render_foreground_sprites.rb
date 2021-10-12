# frozen_string_literal: true

class RenderForegroundSprites < RenderSystem
  filter Tag(:foreground), Sprite, Position

  def tick(args)
    render_sprites(args)
    render_labels(args)
    render_debug_information(args)
    render_world_solved(args)
  end

  private

  def render_labels(args)
    args.outputs.labels << {
      text: "Level #{world.current_level + 1}: \"#{world.level.level_data.name.trim}\" | Moves: #{world.history.size}",
      vertical_alignment_enum: 0, x: 10, y: 10
    }
  end

  def render_sprites(args)
    sprites = entities.map do |entity|
      make_sprite(entity, args)
    end

    args.outputs.sprites << sprites
    args.outputs.sprites << make_sprite(world.player, args)
  end

  def render_debug_information(args)
    return unless world.debug?

    labels = entities.map do |entity|
      debug_label(entity.position.x, entity.position.y, "#{entity.position.x}:#{entity.position.y}", args)
    end
    labels << debug_label(world.player.position.x, world.player.position.y, "#{world.player.position.x}:#{world.player.position.y}", args)
    args.outputs.labels << labels
  end

  def debug_label(x, y, text, args)
    { x: tile_x(x, args) + 5, y: tile_y(y, args) + 10, text: text, size_enum: 2, vertical_alignment_enum: 0, r: 128, g: 0, b: 0 }
  end

  def render_world_solved(args)
    return unless world.solved?

    args.outputs.labels << [
      {
        x: args.grid.w / 2,
        y: args.grid.h / 2,
        text: 'SOLVED!',
        size_enum: 60,
        alignment_enum: 1,
        vertical_alignment_enum: 1
      },
      {
        x: args.grid.w / 2,
        y: args.grid.h / 2 - 100,
        text: 'Press space for next level.',
        size_enum: 24,
        alignment_enum: 1,
        vertical_alignment_enum: 1
      }
    ]
  end
end
