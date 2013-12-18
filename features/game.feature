@start
Feature: Start the Blackjack game
  As a API user
  In order to start a game
  I want to send and receive data for the game
  
  Background:
  	Given my user account exists
    Given I am a valid API user
    And I send and accept JSON
	
  Scenario: Start the game
    Given I send a POST request to "/api/v1/start" with the following:
    """
      {"user_id": 1,"number_of_players": 3}
    """
    Then the response code should be "201"
    And the JSON response body should have the following elements:
		 | game_id              |
		 | game_status          |
		 | game_message         |
		 | user                 |
		 | house                |
		 | artificial_players   |
		
