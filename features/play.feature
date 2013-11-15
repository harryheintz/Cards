@play
Feature: Play the Blackjack game
  As a API user
  In order to Play a game
  I want to send and receive data for game-play
  
  Background:
  	Given my user account exists
	Given my game has started
    Given I am a valid API user
    And I send and accept JSON
	
  Scenario: Play the game
    Given I send a PUT request to "/api/v1/play" with the following:
    """
		{"game_id" : 1,"hit" : true}
    """
	Then the response code should be "200"
	And the JSON response body should have the following elements:
		| game_id           |
		| game_over         |
		| user_bust         |
		| house_bust        |
		| ap_one_bust       |
		| ap_two_bust       |
		| user_twenty_one   |
		| house_twenty_one   |
		| ap_one_twenty_one |
		| ap_two_twenty_one |
		| user_cards        |
		| house_cards       |
		| ap_two_cards      |
		| ap_one_cards      |
		| push              |
		| last_round        |
