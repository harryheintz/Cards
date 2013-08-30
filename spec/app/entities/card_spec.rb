require_relative '../spec_helper'
require_relative '../../../app/entities/artificial_player'
require_relative '../../../app/entities/blackjack_game'
require_relative '../../../app/entities/user'
require_relative '../../../app/entities/dealer'
require_relative '../../../app/entities/card_deck'
require_relative '../../../app/entities/house'
require_relative '../../../app/entities/card'


describe Card do
  
  context "validation" do
  
    it "assigns an id" do
      result = Card.create
      expect(result.id).to eq 1
    end
  
  end
 
end

  

