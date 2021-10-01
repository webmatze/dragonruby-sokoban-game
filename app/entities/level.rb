# frozen_string_literal: true

class Level < Draco::Entity
  component LevelData, name: "no name", raw_data: []

  def data
    @data ||= Normalize.call(level_data.raw_data.join("\n"))
  end
end
