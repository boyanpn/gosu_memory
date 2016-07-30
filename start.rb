require 'gosu'

require_relative "state_playgame.rb"
require_relative "state_game_ended.rb"


class Game < Gosu::Window

  SCREENWIDTH = 480
  SCREENHEIGHT= 270
  
  attr_accessor :best_time
  
  def initialize
    super(SCREENWIDTH, SCREENHEIGHT, {:fullscreen => false})
    self.caption = "Memory Game"
    
    @@images = {}
    @@fonts  = {}

    load_images
    load_fonts

    @best_time = 1000
    
    $current_room = PlayGame.new
  end
  
  def draw
    @@fonts["my_font"].draw("TIME", 380, 10, 1)
    @@fonts["my_font"].draw("BEST", 380, 80, 1)
    @@fonts["my_font"].draw(@best_time, 380, 100, 1)
    
    $current_room.draw
  end
  
  def update
    $current_room.update
  end
      
  def button_down(id)
    if id == Gosu::KbEscape then
        $w.close
    end  

    $current_room.button_down(id)
  end
  
  def button_up(id)
    $current_room.button_up(id)
  end
  
  def Game.images
    @@images
  end
  
  def Game.fonts
    @@fonts
  end
  
  def load_images
    @@images[1] = Gosu::Image.new("./images_animals/camel-head.png", {:retro => true})
    @@images[2] = Gosu::Image.new("./images_animals/donkey.png", {:retro => true})
    @@images[3] = Gosu::Image.new("./images_animals/frog.png", {:retro => true})
    @@images[4] = Gosu::Image.new("./images_animals/lion.png", {:retro => true})
    @@images[5] = Gosu::Image.new("./images_animals/octopus.png", {:retro => true})
    @@images[6] = Gosu::Image.new("./images_animals/sad-crab.png", {:retro => true})
    @@images[7] = Gosu::Image.new("./images_animals/sperm-whale.png", {:retro => true})
    @@images[8] = Gosu::Image.new("./images_animals/sheep.png", {:retro => true})
    @@images[9] = Gosu::Image.new("./images_animals/unicorn.png", {:retro => true})
    @@images[10] = Gosu::Image.new("./images_animals/snail.png", {:retro => true})

    @@images["card_back"] = Gosu::Image.new("./images_animals/card-random.png", {:retro => true})
    @@images["button_play_again"] = Gosu::Image.new("./images_animals/new_game1.png", {:retro => true})
  end
    
  def load_fonts
    @@fonts["my_font"] = Gosu::Font.new(18, {:name => "Courier"})
  end  
 
  def needs_cursor?
    true
  end
end

$w = Game.new
$w.show
