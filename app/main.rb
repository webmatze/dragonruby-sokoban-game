class Game
  attr_gtk

  attr_accessor :player, :level, :level_solids
  attr_reader :tile_width

  def initialize
    @tile_width = 32
    @player ||= Player.new x: 0, y: 0, width: @tile_width
    @level ||= [
      [1,1,1,1,1,1],
      [1,0,0,0,2,1],
      [1,0,1,1,1,1],
      [1,0,1,0,0,1],
      [1,0,0,0,0,1],
      [1,1,1,1,1,1]
    ]
  end

  def init
    @level_solids ||= @level.map_with_index do |row, y|
      row.map_with_index do |col, x|
        x_pos = grid.left + (x*tile_width)
        y_pos = grid.top - tile_width - (y * tile_width)
        case col
        when 1
          Wall.new(x: x_pos, y: y_pos, width: tile_width)
        when 2
          @player.x = x_pos
          @player.y = y_pos
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        else
          Floor.new(x: x_pos, y: y_pos, width: tile_width)
        end
      end
    end.flatten
  end

  def render
    # render level
    outputs.primitives << level_solids.map(&:primitives)
    # render player
    outputs.primitives << player.primitives
    # render ui
    outputs.labels << [10, 30, gtk.current_framerate]
  end
  
  def input
    player.move_right(10) if inputs.right
    player.move_left(10) if inputs.left
    player.move_up(10) if inputs.up
    player.move_down(10) if inputs.down
    if inputs.mouse.inside_rect? player
      player.color = [255,255,0] 
    else
      player.color = [255,0,0]
    end
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
  def move_right(amount=1)
    @x += amount
  end
  def move_left(amount=1)
    @x -= amount
  end
  def move_up(amount=1)
    @y += amount
  end
  def move_down(amount=1)
    @y -= amount
  end
end

class TileBlock
  attr_accessor :x, :y, :w, :h, :path

  def initialize x: 0, y: 0, width: 16, path: ''
    @x = x
    @y = y
    @w = width
    @h = width
    @path = path
  end
end

class Player < TileBlock
  include Moveable

  def primitives
    [
      { x: x, y: y, w: w, h: h, path: 'sprites/Blocks/blobLeft.png'}.sprite
    ]
  end
end

class Wall < TileBlock
  def primitives
    [
      { x: x, y: y, w: w, h: h, path: 'sprites/Blocks/darkStoneBlock.png'}.sprite
    ]
  end
end

class Floor < TileBlock
  def primitives
    [
      { x: x, y: y, w: w, h: h, path: 'sprites/Blocks/darkDirtBlock.png'}.sprite
    ]
  end
end

$game = Game.new

def tick args
  $game.args = args
  $game.tick
end
