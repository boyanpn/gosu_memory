class GameEnded
  def initialize
    @font = Game.fonts["my_font"]
    @button_play_again = Game::images["button_play_again"]
  end
  
  def draw
    @font.draw("CONGRATS, YOU WON!", 100, 110, 1)
    @button_play_again.draw(345, 220, 1)
  end
  
  def update
  end
  
  def button_down(id)
  end
    
  def button_up(id)
    if ($w.mouse_x > 345 && $w.mouse_x < 345+128 && $w.mouse_y > 220 && $w.mouse_y < 220+28)
        $current_room = PlayGame.new
    end
  end
end
