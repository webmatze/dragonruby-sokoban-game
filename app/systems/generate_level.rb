# frozen_string_literal: true

class GenerateLevel < Draco::System
  FLOOR = 0
  WALL = 1
  PLAYER = 2
  BOX = 3
  STORAGE = 4

  def tick(args)
    tiles = world.level_data.map_with_index do |row, y|
      row.map_with_index do |col, x|
        case col
        when WALL
          NewWall.new(position: { x: x, y: y })
        when PLAYER
          world.player.position.x = x
          world.player.position.y = y
          NewFloor.new(position: { x: x, y: y })
        when FLOOR
          NewFloor.new(position: { x: x, y: y })
        when BOX
          [
            NewBox.new(position: { x: x, y: y }),
            NewFloor.new(position: { x: x, y: y })
          ]
        when STORAGE
          [
            NewStorage.new(position: { x: x, y: y }),
            NewFloor.new(position: { x: x, y: y })
          ]
        end
      end
    end.flatten.compact

    world.entities << tiles

    world.systems.delete(GenerateLevel)
  end
end