# frozen_string_literal: true

class PlayLevel < Draco::World
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

  def reset
    @solved = false
    @level_data = nil
    @entities.select_entities(Draco::Tag(:background)).each do |entity|
      @entities.delete(entity)
    end
    @entities.select_entities(Draco::Tag(:foreground)).each do |entity|
      @entities.delete(entity)
    end
    @systems.push(GenerateLevel)
    @systems.push(CheckLevelSolved)
  end

  def level_data
    @level_data ||= load_level
  rescue StandardError => e
    puts e.message, e.backtrace
    @current_level = 0
    @level_data || load_level
  end

  def load_level
    level = levels.to_a[current_level]
    puts "load level #{level.level_data.name}..."
    level.data.map do |line|
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

  def levels
    entities.select_entities Draco::Tag(:level_data)
  end
end
