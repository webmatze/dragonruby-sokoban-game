# frozen_string_literal: true

class GenerateLevel < Draco::System
  FLOOR = 0
  WALL = 1
  PLAYER = 2
  BOX = 3
  STORAGE = 4

  def tick(args)
    tile_width = 64
    tiles = world.level_data.map_with_index do |row, y|
      row.map_with_index do |col, x|
        x_pos = args.grid.left + (x * tile_width) + ((args.grid.w / 2) - (world.level_data.size * tile_width / 2))
        y_pos = args.grid.top - tile_width - (y * tile_width) - ((args.grid.h / 2) - (row.size * tile_width / 2))
        case col
        when WALL
          NewWall.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width })
        when PLAYER
          world.player.position.x = x_pos
          world.player.position.y = y_pos
          NewFloor.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width })
        when FLOOR
          NewFloor.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width })
        when BOX
          [
            NewBox.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width }),
            NewFloor.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width })
          ]
        when STORAGE
          [
            NewStorage.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width }),
            NewFloor.new(position: { x: x_pos, y: y_pos }, size: { width: tile_width, height: tile_width })
          ]
        end
      end
    end.flatten.compact

    world.entities << tiles

    world.systems.delete(GenerateLevel)
  end
end