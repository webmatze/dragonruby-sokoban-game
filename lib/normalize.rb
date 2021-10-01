# frozen_string_literal: true

class Normalize
  def self.call(xsb)
    rows = xsb.split("\n")
    data = rows.map do |row|
      row.split('')
    end
    player_pos = get_player_pos(data)
    fill_floor(data, player_pos[0], player_pos[1])
    fill_outer_area(data)
    data
  end

  def self.fill_floor(data, x, y)
    checked = []
    stack = []
    stack.push [x, y]

    while stack.any?
      x, y = stack.pop

      cur_col = data[y][x]
      next unless [' ', '@', '.', '$', '+', '*'].include? cur_col

      data[y][x] = '-' if cur_col == ' '
      next if checked.include? [x, y]

      checked.push [x, y]

      stack.push([x, y + 1]) unless checked.include?([x, y + 1])
      stack.push([x, y - 1]) unless checked.include?([x, y - 1])
      stack.push([x + 1, y]) unless checked.include?([x + 1, y])
      stack.push([x - 1, y]) unless checked.include?([x - 1, y])
    end
  end

  def self.fill_outer_area(data)
    max_row_length = data.sort_by(&:size).last.size
    data.map.with_index do |row, y|
      row.map.with_index do |col, x|
        data[y][x] = '_' if col == ' '
      end
      fill = max_row_length - row.size
      fill.times { row << '_' }
    end
  end

  def self.get_player_pos(data)
    pos = []
    data.each_with_index do |row, y|
      row.each_with_index do |col, x|
        pos = [x, y] if ['@', '+'].include? col
      end
    end
    pos
  end
end
