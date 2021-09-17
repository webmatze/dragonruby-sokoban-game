# frozen_string_literal: true

class Level1 < Draco::World
  entity NewPlayer, as: :player

  systems GenerateLevel
  systems HandleInput
  systems HandleDirection
  systems RenderBackgroundSprites
  systems RenderForegroundSprites
  systems RenderDebugData

  def level_data
    [
      [1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 2, 1],
      [1, 0, 1, 1, 1, 1],
      [1, 0, 3, 0, 4, 1],
      [1, 1, 0, 3, 4, 1],
      [nil, 1, 1, 1, 1, 1]
    ]
  end
end
