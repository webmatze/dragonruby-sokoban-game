# frozen_string_literal: true

class LoadLevels < Draco::System
  filter Tag(:level_data)

  def tick(args)
    return if levels.any?

    level = Level.new(level_data: { raw_data: [], name: "no name" })

    levels_data = $gtk.read_file "/data/FuerEnnaUndVigo.txt"
    levels_data.lines.each do |line|
      line = line.chomp
      if line.trim.empty?
        # add level
        world.entities << level
        level = Level.new(level_data: { raw_data: [], name: "no name" })
        puts "new level", level
      elsif line.start_with? ';'
        # load level name
        level.level_data.name = line[1..]
      else
        level.level_data.raw_data.push line
      end
    end
    puts "loaded #{levels.to_a.length} levels."

    world.systems.delete(LoadLevels)
  end

  private

  def levels
    entities
  end
end
