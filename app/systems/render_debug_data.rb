# frozen_string_literal: true

class RenderDebugData < Draco::System
  def tick(args)
    debug_data = [
      "fps: #{args.gtk.current_framerate.round}",
      "ticks: #{args.state.tick_count}",
      "player_direction: #{world.player.direction.points_to}",
      "zoom: #{world.tile_size}"
    ]
    args.outputs.labels << [10, 30, debug_data.join(", ")]
  end
end
