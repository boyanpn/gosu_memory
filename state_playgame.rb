class PlayGame
 
  POSITION = {
    0 => [2, 2, 1],
    1 => [69, 2, 1],
    2 => [136, 2, 1],
    3 => [203, 2, 1],
    4 => [270, 2, 1],
    5 => [2, 69, 1],
    6 => [69, 69, 1],
    7 => [136, 69, 1],
    8 => [203, 69, 1],
    9 => [270, 69, 1],
    10 => [2, 136, 1],
    11 => [69, 136, 1],
    12 => [136, 136, 1],
    13 => [203, 136, 1],
    14 => [270, 136, 1],
    15 => [2, 203, 1],
    16 => [69, 203, 1],
    17 => [136, 203, 1],
    18 => [203, 203, 1],
    19 => [270, 203, 1]
  }
  
  def initialize
    @font = Game::fonts["my_font"]
    @card_back = Game::images["card_back"]
    @cards = []
    load_cards
    
    @current_time = 0; @start_time = Gosu::milliseconds/1000
    
    @last_clicked_card = nil
    @click = 0
    @first_card_opened = nil
    @second_card_opened = nil
  end
  
  def draw
    @font.draw(@current_time, 380, 30, 1)
    
    0.upto(19) do |i|
      if !@cards[i]
        next
      elsif (@second_card_opened == i) && @click.even?
        @cards[@second_card_opened].draw(*POSITION[@second_card_opened])
      elsif @first_card_opened == i
        @cards[@first_card_opened].draw(*POSITION[@first_card_opened])
      else  
        @card_back.draw(*POSITION[i])
      end
    end
  end
  
  def update
    @current_time = (Gosu::milliseconds/1000)-@start_time
  end
  
  def button_down(id)
  end
    
  def button_up(id)
    if id == Gosu::MsLeft then 
      POSITION.each do |k, arr|
        if $w.mouse_x > arr[0] && $w.mouse_x < arr[0]+64 && $w.mouse_y > arr[1] && $w.mouse_y < arr[1]+64 && @cards[k] != nil && @last_clicked_card != k
          @last_clicked_card = k if @last_clicked_card
          @click += 1
          if @click.odd? 
            @first_card_opened = k
          else
            @second_card_opened = k
          end
        end
      end
      if @first_card_opened && @second_card_opened && @click.even? && (@cards[@first_card_opened] == @cards[@second_card_opened]) && (@first_card_opened != @second_card_opened)
        @cards[@first_card_opened] = nil
        @cards[@second_card_opened] = nil
        @first_card_opened = nil
        @second_card_opened = nil
      end
      if game_ended
        $current_room = GameEnded.new
      end
    end
  end
  
  def load_cards
    2.times do
      1.upto(10) do |i|
        @cards << Game::images[i]
      end
    end
    @cards = @cards.shuffle
  end
  
  def game_ended
    if @cards[0..19] == Array.new(20)
      if $w.best_time > @current_time
        $w.best_time = @current_time
      end
      return true
    end  
  end
  
end
