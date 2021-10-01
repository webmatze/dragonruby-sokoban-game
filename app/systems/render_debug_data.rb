# frozen_string_literal: true

class RenderDebugData < Draco::System
  def tick(args)
    return unless world.debug?

    debug_data = [
      "player_direction: #{world.player.direction.points_to}",
      "zoom: #{world.tile_size}"
    ]
    debug_primitives = args.gtk.framerate_diagnostics_primitives
    debug_primitives[0][:h] += 15
    debug_primitives[0][:y] -= 15
    debug_primitives << {:x=>5, :y=>655 - 15, :text=>debug_data.join(", "), :r=>255, :g=>255, :b=>255, :size_enum=>-2, :primitive_marker=>:label}
    args.outputs.debug << debug_primitives
  end
end
