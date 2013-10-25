@play
Feature: Play the Blackjack game
  As a API user
  In order to Play a game
  I want to send and receive data for game-play
  
  Scenario: Playing the game
    Given I am a valid API user
    And I send and accept JSON
    When I send a PUT request to "/api/v1/play" with the following:
	#<whatever the api message will be from UI>
	Then <is this a response code? or a way of validating the api is working?>
	And <the API should return this infor to me:...>