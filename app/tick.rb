# frozen_string_literal: true

$gtk.reset

def tick(args)
  $level ||= Level1.new
  $level.tick(args)
end
