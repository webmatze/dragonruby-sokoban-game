# frozen_string_literal: true

class Level1 < Draco::World
  attr_accessor :debug, :solved, :current_level, :tile_size
  entity NewPlayer, as: :player

  systems LoadLevels
  systems GenerateLevel
  systems HandleDirection
  systems HandleInput
  systems CheckLevelSolved
  systems RenderBackgroundSprites
  systems RenderForegroundSprites
  systems RenderDebugData

  def after_initialize
    @current_level = 0
    @solved = false
    @tile_size = 64
  end

  def level_data
    @level_data ||= load_level
  rescue StandardError => e
    puts e.message, e.backtrace
    @current_level = 0
    @level_data || load_level
  end

  def load_level
    $gtk.args.state.levels[current_level].map do |line|
      line.map do |char|
        case char
        when '_' then nil
        when '#' then GenerateLevel::WALL
        when '-' then GenerateLevel::FLOOR
        when '$' then GenerateLevel::BOX
        when '.' then GenerateLevel::STORAGE
        when '@' then GenerateLevel::PLAYER
        when '+' then GenerateLevel::PLAYER_ON_STORAGE
        when '*' then GenerateLevel::BOX_ON_STORAGE
        end
      end
    end
  end

  def solved?
    solved
  end

  def debug?
    debug
  end
end
