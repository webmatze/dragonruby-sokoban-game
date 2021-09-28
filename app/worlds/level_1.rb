# frozen_string_literal: true

class Level1 < Draco::World
  attr_accessor :debug, :solved, :current_level, :tile_size
  entity NewPlayer, as: :player

  systems GenerateLevel
  systems HandleDirection
  systems HandleInput
  systems CheckLevelSolved
  systems RenderBackgroundSprites
  systems RenderForegroundSprites
  systems RenderDebugData

  def after_initialize
    @current_level = 1
    @solved = false
    @tile_size = 64
  end

  def levels
    [
      [
        [1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 2, 1],
        [1, 0, 1, 1, 1, 1],
        [1, 0, 3, 0, 4, 1],
        [1, 1, 0, 3, 4, 1],
        [nil, 1, 1, 1, 1, 1]
      ],
      [
        [nil, nil, nil, nil, 1, 1, 1, 1, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, 1, 0, 0, 0, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, nil, nil, 1, 3, 0, 0, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 1, 1, 1, 0, 0, 3, 1, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 1, 0, 0, 3, 0, 3, 0, 1, nil, nil, nil, nil, nil, nil, nil, nil, nil],
        [1, 1, 1, 0, 1, 0, 1, 1, 0, 1, nil, nil, nil, 1, 1, 1, 1, 1, 1],
        [1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 4, 4, 1],
        [1, 0, 3, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1],
        [1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 2, 1, 1, 0, 0, 4, 4, 1],
        [nil, nil, nil, nil, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1],
        [nil, nil, nil, nil, 1, 1, 1, 1, 1, 1, 1, nil, nil, nil, nil, nil, nil, nil, nil]
      ]
    ]
  end

  def level_data
    levels[current_level]
  end

  def solved?
    solved
  end

  def debug?
    debug
  end
end
