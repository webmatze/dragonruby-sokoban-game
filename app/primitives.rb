# frozen_string_literal: true

class TileBlock
  include AttrRect

  attr_accessor :x, :y, :w, :h, :path, :angle

  def initialize(x: 0, y: 0, width: 16, path: nil)
    @x = x
    @y = y
    @w = width
    @h = width
    @path = path
    @angle = 0
  end

  def to_rect
    [x, y, w, h]
  end

  def primitives
    [
      { x: x, y: y, w: w, h: h, path: path, angle: angle }.sprite!
    ]
  end
end

class Player < TileBlock
  include Moveable

  attr_accessor :direction

  def initialize(x: nil, y: nil, width: nil, path: nil)
    super(x: x, y: y, width: width, path: path)
    look_down
  end

  def look_right
    @direction = :right
    @angle = 90
  end

  def look_left
    @direction = :left
    @angle = 270
  end

  def look_up
    @direction = :up
    @angle = 180
  end

  def look_down
    @direction = :down
    @angle = 0
  end

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
