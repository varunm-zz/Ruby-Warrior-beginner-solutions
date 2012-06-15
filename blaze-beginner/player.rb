class Player
  @@walk = false
  def play_turn(warrior)
    if warrior.feel(:backward).wall?
      @@walk = true
    end
    @empty = false
    if @@walk == false
      @empty = warrior.feel(:backward).empty?
    else
      @empty = warrior.feel.empty?
    end
    if warrior.feel.wall?
      warrior.pivot!
    elsif @empty
      if ((@health == nil) or (@health > warrior.health))
        if warrior.health >12
          if @@walk == false
            warrior.walk!(:backward)
          else
            warrior.walk!
          end
        else
          warrior.walk!(:backward)
        end
      elsif warrior.health <= 15
        warrior.rest!
      else
        if @@walk == false
          warrior.walk!(:backward)
        else
          warrior.walk!
        end
      end
    elsif warrior.feel.captive?
      warrior.rescue!
    elsif warrior.feel(:backward).captive?
      warrior.rescue!(:backward)
    else
      warrior.attack!
    end
    @health = warrior.health
  end
end
