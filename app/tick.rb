# frozen_string_literal: true

$gtk.reset

def tick(args)
  args.state.level ||= Level1.new
  args.state.level.tick(args)
end
