# frozen_string_literal: true

class Game
  attr_gtk

  attr_accessor :player, :level, :level_solids, :level_movables
  attr_reader :tile_width

  FLOOR = 0
  WALL = 1
  PLAYER = 2
  BOX = 3
  STORAGE = 4

  def initialize
    @tile_width = 64
    @player ||= Player.new x: 0, y: 0, width: @tile_width
    @level ||= [
      [1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 2, 1],
      [1, 0, 1, 1, 1, 1],
      [1, 0, 3, 0, 4, 1],
      [1, 1, 0, 3, 4, 1],
      [1, 1, 1, 1, 1, 1]
    ]
  end

  def init
    @level_movables ||= []
    @level_solids   ||= @level.map_with_index do |row, y|
      row.map_with_index do |col, x|
        x_pos = grid.left + (x * tile_width)
        y_pos = grid.top - tile_width - (y * tile_width)
        case col
        when WALL
          Wall.new(x: x_pos, y: y_pos, width: tile_width)
        when PLAYER
          @player.x = x_pos
          @player.y = y_pos
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        when FLOOR
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        when BOX
          @level_movables << Box.new(x: x_pos, y: y_pos, width: tile_width)
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        when STORAGE
          @level_movables << Storage.new(x: x_pos, y: y_pos, width: tile_width)
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        end
      end
    end.flatten
  end

  def render
    # render level
    outputs.primitives << level_solids.map(&:primitives)
    # render movables
    outputs.primitives << level_movables.map(&:primitives)
    # render player
    outputs.primitives << player.primitives
    # render ui
    debug_data = "fps: #{gtk.current_framerate.round}, ticks: #{state.tick_count}, player_direction: #{player.direction}"
    outputs.labels << [10, 30, debug_data]
  end

  def input
    amount = 4
    if inputs.right
      player.look_right
      player.move_right(amount) if player.can_move_right?(level_solids, amount)
    end

    if inputs.left
      player.look_left
      player.move_left(amount) if player.can_move_left?(level_solids, amount)
    end

    if inputs.up
      player.look_up
      player.move_up(amount) if player.can_move_up?(level_solids, amount)
    end

    if inputs.down
      player.look_down
      player.move_down(amount) if player.can_move_down?(level_solids, amount)
    end
  end

  def calc
    player.x = 0 if player.x.negative?
    player.y = 0 if player.y.negative?
    player.x = grid.right - player.w if player.x + player.w > grid.right
    player.y = grid.top - player.h if player.y + player.h > grid.top
  end

  def tick
    init
    render
    input
    calc
  end
end
