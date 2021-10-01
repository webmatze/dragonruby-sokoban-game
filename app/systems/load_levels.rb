# frozen_string_literal: true

class LoadLevels < Draco::System
  def tick(args)
    return if args.state.levels.any?

    args.state.levels = []

    levels_data = $gtk.read_file "/data/AC_Easy.txt"
    puts levels_data
    level = []
    level_name = ''
    levels_data.lines.each do |line|
      line = line.chomp
      if line.trim.empty?
        # add level
        normalized_level = Normalize.call(level.join("\n"))
        args.state.levels << normalized_level
        level = []
      elsif line.start_with? ';'
        # load level name
        level_name = line[1..]
      else
        level.push line
      end
    end
    puts "loaded #{args.state.levels.size} levels."

    world.systems.delete(LoadLevels)
  end
end
