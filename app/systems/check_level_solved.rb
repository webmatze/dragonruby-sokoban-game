# frozen_string_literal: true

class CheckLevelSolved < Draco::System
  filter Pushable

  STORAGE_TARGETS = [GenerateLevel::STORAGE, GenerateLevel::BOX_ON_STORAGE, GenerateLevel::PLAYER_ON_STORAGE].freeze

  def tick(_args)
    solved = entities.any? && entities.all? do |entity|
      STORAGE_TARGETS.include? world.level_data[entity.position.y][entity.position.x]
    end
    return unless solved

    world.solved = true
    world.systems.delete(CheckLevelSolved)
  end
end
