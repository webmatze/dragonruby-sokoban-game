$gtk.reset

class Game
  attr_gtk

  attr_accessor :player, :level, :level_solids, :level_moveables
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
    @level_moveables ||= []
    @level_solids ||= @level.map_with_index do |row, y|
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
          @level_moveables << Box.new(x: x_pos, y: y_pos, width: tile_width)
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        when STORAGE
          @level_moveables << Storage.new(x: x_pos, y: y_pos, width: tile_width)
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        end
      end
    end.flatten
  end

  def render
    # render level
    outputs.primitives << level_solids.map(&:primitives)
    # render moveables
    outputs.primitives << level_moveables.map(&:primitives)
    # render player
    outputs.primitives << player.primitives
    # render ui
    debug_data = "fps: #{gtk.current_framerate.round}, ticks: #{state.tick_count}"
    outputs.labels << [10, 30, debug_data]
  end

  def input
    amount = 2
    player.move_right(amount) if inputs.right && player.can_move_right?(level_solids, amount)
    player.move_left(amount) if inputs.left && player.can_move_left?(level_solids, amount)
    player.move_up(amount) if inputs.up && player.can_move_up?(level_solids, amount)
    player.move_down(amount) if inputs.down && player.can_move_down?(level_solids, amount)
  end

  def calc
    player.x = 0 if player.x < 0
    player.y = 0 if player.y < 0
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

module Moveable
  def can_move_right?(solids, amount=1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(self.dup.tap {|s| s.x += amount })
    end
  end
  def can_move_left?(solids, amount=1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(self.dup.tap {|s| s.x -= amount })
    end
  end
  def can_move_up?(solids, amount=1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(self.dup.tap {|s| s.y += amount })
    end
  end
  def can_move_down?(solids, amount=1)
    solids.none? do |solid|
      solid.is_a?(Wall) && solid.intersect_rect?(self.dup.tap {|s| s.y -= amount })
    end
  end

  def move_right(amount = 1)
    @x += amount
  end

  def move_left(amount = 1)
    @x -= amount
  end

  def move_up(amount = 1)
    @y += amount
  end

  def move_down(amount = 1)
    @y -= amount
  end
end

class TileBlock
  include AttrRect

  attr_accessor :x, :y, :w, :h, :path

  def initialize(x: 0, y: 0, width: 16, path: nil)
    @x = x
    @y = y
    @w = width
    @h = width
    @path = path
  end

  def to_rect
    [x, y, w, h]
  end

  def primitives
    [
      { x: x, y: y, w: w, h: h, path: path }.sprite
    ]
  end
end

class Player < TileBlock
  include Moveable

  def path
    @path || 'sprites/Blocks/blobLeft.png'
  end
end

class Wall < TileBlock
  def path
    @path || 'sprites/Blocks/stoneBlock.png'
  end
end

class Floor < TileBlock
  def path
    @path || 'sprites/Blocks/sandBlock.png'
  end
end

class Box < TileBlock
  def path
    @path || 'sprites/Blocks/purpleBlock.png'
  end
end

class Storage < TileBlock
  include Moveable

  def path
    @path || 'sprites/Blocks/heart.png'
  end
end

$game = Game.new

def tick(args)
  $game.args = args
  $game.tick
end
