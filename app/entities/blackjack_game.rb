require_relative "./shared"
require 'dm-validations'

class BlackjackGame
  include DataMapper::Resource, Outcomes, Shared, Procedures
  property :id,                   Serial #blackjack_game.id
  property :number_of_players,    Integer, :required => true
  has n, :players
  has 1, :dealer
  has 1, :house
  has 1, :user
  has n, :artificial_players
  attr_accessor :initial_cards, :hit, :split, :stand, :message
  
  def self.prepare(parsed_json)
    user = User.get(parsed_json["user_id"])
    attributes = {:user => user, :number_of_players => parsed_json["number_of_players"]}
    game = create(attributes)
    return nil unless game.valid?
    game.user.cards.destroy
    game.dealer = Dealer.new
    game.house = House.new
    game.create_artificial_players unless game.number_of_players < 2
    game.save
    game.cards_for_first_deal
    game.first_deal
    game
    
  end
  
  def self.start(parsed_json)
    game = self.prepare(parsed_json)
    response =  {
                "game_id" => game.id,
                "game_status" => game.game_status, #game_over, blackjack, push, continue
                "game_message" => game.user.busted?,
                "user" => { "user_id" => game.user.id,
                            "cards" => game.user.response,
                            "message" => game.user.message,
                            "status" => game.user.status },
                "house" => { "house_id" => game.house.id,
                             "cards" => game.house.response,
                             "message" => game.house.message,
                             "status" => game.house.status},
                artificial_players => [
                  game.artificial_players.each do |ap|
                    { "ap_id" => ap.id,
                      "cards" => ap.response,
                      "message" => ap.message,
                      "status" => ap.status} #deal with comma
                  end
                ]
              }
     # {
#                 "game_id" => game.id,
#                 "user_cards" => game.user.response,
#                 "house_cards" => game.house.response,
#                 "ap_one_cards" => game.artificial_players.first.response,
#                 "ap_two_cards" => game.artificial_players.last.response,
#                 "user_split" => game.user.can_split?,
#                 "user_blackjack_win" => game.user.blackjack?,
#                 "house_blackjack_win" => game.house.blackjack?,
#                 "ap_one_blackjack_win" => game.artificial_players.first.blackjack?,
#                 "ap_two_blackjack_win" => game.artificial_players.last.blackjack?,
#                 "first_round_push" => game.first_round_push?
#                 }
  end
  
  def self.play(options)
    game = BlackjackGame.get(options["game_id"])
    game.process_user_hit   if options["hit"] == true
    game.process_user_stand if options["stand"] == true
    game.process_user_split if options["split"] == true
    # response = {
    #             "game_id" => game.id,
    #             "game_over" => game.game_over?,
    #             "user_bust" => game.user.busted?,
    #             "house_bust" => game.house.busted?,
    #             "ap_one_bust" => game.artificial_players.first.busted?,
    #             "ap_two_bust" => game.artificial_players.last.busted?,
    #             "user_twenty_one" => game.user.twenty_one?,
    #             "house_twenty_one" => game.house.twenty_one?,
    #             "ap_one_twenty_one" => game.artificial_players.first.twenty_one?,
    #             "ap_two_twenty_one" => game.artificial_players.last.twenty_one?,
    #             "user_cards" => game.user.response,
    #             "house_cards" => game.house.response,
    #             "ap_one_cards" => game.artificial_players.first.response,
    #             "ap_two_cards" => game.artificial_players.last.response,
    #             "push" => game.is_push?, 
    #             "last_round" => game.card_exhaustion?
    #           }
    
    response = {
                "game_id" => game.id,
                "game_status" =>  game.game_status,#game_over, blackjack, push, continue
                "game_message" => game.user.busted?,
                "user" => { "user_id" => game.user.id,
                            "cards" => game.user.response,
                            "message" => game.user.message,
                            "status" => game.user.status },
                "house" => { "house_id" => game.house.id,
                             "cards" => game.house.response,
                             "message" => game.house.message ,
                             "status" => game.house.status},
                artificial_players => [
                  game.artificial_players.each do |ap|
                    { "ap_id" => ap.id,
                      "cards" => ap.response,
                      "message" => ap.message,
                      "status" => ap.status} #deal with comma
                  end
                ]
              }
  end
  
  def hit(player)
    card = create_card(get_dealer_cards(1))
    player.cards << card
    player.save
  end
  
  def hit_split(player)
    card = create_card(get_dealer_cards(1), hidden=false, split=true)
    player.cards << card
    player.save  
  end
  
  def create_artificial_players
    ap = number_of_players - 2
    ap.downto(1) do |n|
      self.artificial_players << ArtificialPlayer.create
    end
    self.save
  end
  
  def number_of_cards_for_initial_deal
    number_of_players * 2
  end
  
  def cards_for_first_deal
    @initial_cards = dealer.deal(number_of_cards_for_initial_deal)
  end
  
  def get_dealer_cards(count)
    hash = dealer.deal(count).shift
    hash = hash.inject({}){|card,(a,b)| card[a.to_sym] = b; card}
    hash
  end
  
  def first_deal
    associate_down_card_for(user)
    associate_down_card_for(house)
    artificial_players.each do |ap|
      associate_down_card_for(ap)
    end
    associate_up_card_for(user)
    associate_up_card_for(house)
    artificial_players.each do |ap|
      associate_up_card_for(ap)
    end
  end
  
  def associate_up_card_for(player)
    card = create_card(@initial_cards.shift)
    player.cards << card
    player.save
  end
  
  def associate_down_card_for(player)
    card = create_card(@initial_cards.shift, hidden=true)
    player.cards << card
    player.save
  end
  
  def create_card(card_hash, hidden=false, split=false)
    value = calculate_card_value(card_hash[:name])
    attributes = { :name => card_hash[:name], :suit => card_hash[:suit], :value => value, :hidden => hidden, :split => split}
    card = Card.create(attributes)
  end
  
  def calculate_card_value(string)
    string.gsub!(/[JQK]/, "10" )
    string.to_i
  end
  
  def game_status
    "Thanks for playing, Buh Bye!" if game_over?
    
  end
  
end
  



