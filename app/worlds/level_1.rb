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
    @current_level = 0
    @solved = false
    @tile_size = 64
  end

  def level_data
    @level_data ||= load_level
  rescue StandardError
    @current_level = 0
    @level_data || load_level
  end

  def load_level
    level_xsb_data = $gtk.read_file "/data/level_#{current_level}.xsb"
    raise StandardError, "level file /data/level_#{@current_level}.xsb not found" unless level_xsb_data

    level_xsb_data.each_line.map do |line|
      line.split('').map do |char|
        case char
        when '_' then nil
        when '#' then GenerateLevel::WALL
        when '-' then GenerateLevel::FLOOR
        when '$' then GenerateLevel::BOX
        when '.' then GenerateLevel::STORAGE
        when '@' then GenerateLevel::PLAYER
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
