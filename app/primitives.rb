# frozen_string_literal: true

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
