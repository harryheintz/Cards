@start
Feature: Start the Blackjack game
  As a API user
  In order to start a game
  I want to send and receive data for the game
  
  Scenario: Start the game
    Given I am a valid API user
    And I send and accept JSON
    When I send a POST request to "/api/v1/start" with the following:
    """
      {"user_id": 1,"number_of_players": 3}
    """
    Then the response code should be "201"
    And the JSON response body should have the following elements:
			| game_id                     |
			| user_cards                  |
			| house_cards                 |
			| ap_one_cards                |
			| ap_two_cards                |
			| play_actions                |
			| game_message                |
			| game_staus                  |
			| hit|
			| stand|
			| split|
			| user_win|
			| house_win|
			| ap_one_win                |
			| ap_two_win                |
		