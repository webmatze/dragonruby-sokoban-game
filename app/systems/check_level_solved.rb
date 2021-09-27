# frozen_string_literal: true

class CheckLevelSolved < Draco::System
  filter Pushable

  def tick(_args)
    solved = entities.all? do |entity|
      world.level_data[entity.position.y][entity.position.x] == GenerateLevel::STORAGE
    end
    if solved
      world.solved = true
      world.systems.delete(CheckLevelSolved)
      world.systems.delete(HandleDirection)
    end
  end
end
