class CheckBoxOnTarget < Draco::System
  filter Pushable

  def tick(args)
    entities.each do |box|
      if CheckLevelSolved::STORAGE_TARGETS.include? world.level_data[box.position.y][box.position.x]
        box.sprite.path = NewBox::ON_TARGET_BOX
      else
        box.sprite.path = NewBox::NORMAL_BOX
      end
    end
  end
end